<?php

namespace FoxAI;

use think\facade\Db;

class hub
{
    protected static $site_id = 0;
    protected static $ai = '';
    protected static $keyType = '';
    protected static $apiKey = '';
    // 系统前置指令
    protected static $systemPrompt = '';
    // 关联的上文内容
    protected static $relationMsgs = [];
    // 准备提交的文本内容
    protected static $message = '';
    // 输出文字的回调方法
    protected static $replyCallback = null;
    // 输出错误的回调方法
    protected static $errorCallback = null;
    // 上文最大长度 - 默认3000
    protected static $maxRelationLength = 3000;


    /**
     * @param $site_id
     * @param $ai
     */
    public function __construct($site_id, $ai = '')
    {
        self::$site_id = $site_id;
        self::$ai = $ai;
    }

    public function setSystemPrompt($systemPrompt)
    {
        self::$systemPrompt = $systemPrompt;
    }

    public function setRelationMsgs($relationMsgs)
    {
        self::$relationMsgs = $relationMsgs;
    }

    public function setMessage($message)
    {
        self::$message = $message;
    }
    public function setCallback($replyCallback = null, $errorCallback = null)
    {
        self::$replyCallback = $replyCallback;
        self::$errorCallback = $errorCallback;
    }

    private function initAiSDK()
    {
        // 获取AI通道配置
        $aiSetting = getAiSetting(self::$site_id, self::$ai);
        if (empty($aiSetting)) {
            $this->throwError('请先启用AI通道');
        }
        if (in_array(self::$ai, ['chatglm', 'openllm', 'localai'])) {
            $this->throwError('暂不支持此接口');
        }
        // 计算上下文最大字数长度
        if (!empty($aiSetting['model'])) {
            $maxlen = Db::name('engine')
                ->where([
                    ['type', '=', self::$ai],
                    ['name', '=', $aiSetting['model']]
                ])
                ->value('maxlen');
            if ($maxlen) {
                if (!empty($aiSetting['max_tokens'])) {
                    self::$maxRelationLength = intval((intval($maxlen) - intval($aiSetting['max_tokens'])) * 0.7);
                } else {
                    self::$maxRelationLength = intval($maxlen);
                }
            }
        }
        // 获取KEY
        $keyType = self::$ai;
        if (self::$ai == 'openai3' || self::$ai == 'openai4') {
            if ($aiSetting['channel'] == 'api2d') {
                $keyType = 'api2d';
            }
        } elseif (self::$ai == 'azure_openai3' || self::$ai == 'azure_openai4') {
            $keyType = 'azure';
        } elseif (self::$ai == 'wenxin' || self::$ai == 'wenxin4') {
            $keyType = 'wenxin';
        }
        $this->getApiKey($keyType);
        // 初始化各AI通道SDK对象
        switch (self::$ai) {
            case 'openai3':
            case 'openai4':
                if ($aiSetting['channel'] == 'api2d') {
                    $this->getApiKey('api2d');
                }
                $diyhost = $aiSetting['diyhost'];
                if ($diyhost == 'https://api.openai.com') {
                    $apiSetting = getSystemSetting(0, 'api');
                    if ($apiSetting['channel'] == 'agent' && $apiSetting['agent_host']) {
                        $diyhost = rtrim($apiSetting['agent_host'], '/');
                    }
                }
                $SDK = new \ChatGPT\openai(self::$apiKey, $aiSetting['model'], $aiSetting['temperature'], $aiSetting['max_tokens']);
                $SDK->setApiHost($diyhost);
                break;
            case 'wenxin':
            case 'wenxin4':
                $temp = explode('|', self::$apiKey);
                $apikey = $temp[0];
                $secretkey = $temp[1] ?? '';
                $SDK = new \ChatGPT\wenxin($apikey, $secretkey, $aiSetting['model'], $aiSetting['temperature']);
                break;
            case 'lxai':
                $SDK = new \ChatGPT\lxai(self::$apiKey, $aiSetting['model'], $aiSetting['temperature'], $aiSetting['max_tokens']);
                break;
            case 'xunfei':
                $temp = explode('|', self::$apiKey);
                $appid = $temp[0] ?? '';
                $apisecret = $temp[1] ?? '';
                $apikey = $temp[2] ?? '';
                $SDK = new \ChatGPT\xunfei($appid, $apikey, $apisecret, $aiSetting['model'], $aiSetting['temperature'], $aiSetting['max_tokens']);
                break;
            case 'hunyuan':
                $temp = explode('|', self::$apiKey);
                $appid = $temp[0] ?? '';
                $secretId = $temp[1] ?? '';
                $secretKey = $temp[2] ?? '';
                $SDK = new \ChatGPT\hunyuan($appid, $secretId, $secretKey, $aiSetting['temperature']);
                break;
            case 'tongyi':
                $maxTokens = isset($aiSetting['max_tokens']) ? intval($aiSetting['max_tokens']) : 1500;
                $SDK = new \ChatGPT\tongyi(self::$apiKey, $aiSetting['model'], $aiSetting['temperature'], $maxTokens);
                break;
            case 'zhipu':
                $maxTokens = isset($aiSetting['max_tokens']) ? intval($aiSetting['max_tokens']) : 3000;
                $SDK = new \ChatGPT\zhipu(self::$apiKey, $aiSetting['model'], $aiSetting['temperature'], $maxTokens);
                break;
            case 'minimax':
                $temp = explode('|', self::$apiKey);
                $groupId = $temp[0] ?? '';
                $apiKey = $temp[1] ?? '';
                $SDK = new \ChatGPT\minimax($groupId, $apiKey, $aiSetting['temperature'], $aiSetting['max_tokens']);
                break;
            case 'claude2':
                $SDK = new \ChatGPT\claude2(self::$apiKey, $aiSetting['model'], $aiSetting['temperature'], $aiSetting['max_tokens']);
                break;
            case 'azure_openai3':
            case 'azure_openai4':
                $temp = explode('|', self::$apiKey);
                $key = $temp[0] ?? '';
                $diyhost = $temp[1] ?? '';
                $SDK = new \ChatGPT\azure($key, $aiSetting['model'], $aiSetting['temperature'], $aiSetting['max_tokens']);
                $SDK->setApiHost($diyhost);
                break;
            case 'chatglm':
                // todo
                break;
            case 'openllm':
                // todo
                break;
            case 'localai':
                // todo
                break;
        }

        return $SDK;
    }

    /**
     * @param string $message
     * @return array
     * 流式输出
     */
    public function sendText()
    {
        $SDK = $this->initAiSDK();
        $replyCallback = self::$replyCallback;
        $errorCallback  = self::$errorCallback;

        $respTemp = '';
        $respFunc = function ($ch, $data) use (&$respTemp, $replyCallback, $errorCallback) {
            $dataLength = strlen($data);
            // file_put_contents('./data.txt', $data . "|", 8);

            // 判断是否报错并处理
            $error = $this->parseError($data);
            if ($error && $errorCallback) {
                $errorCallback($error);
            }

            if (in_array(self::$ai, ['openai3', 'openai4', 'azure_openai3', 'azure_openai4', 'wenxin', 'wenxin4', 'lxai', 'tongyi'])) {
                if (strpos($data, 'rate_limit_usage') !== false) {
                    $wordArr = [' Rate limit..', 'data: [DONE]'];
                } else {
                    // 一条data可能会被截断分多次返回
                    $respTemp .= $data;
                    if (substr($respTemp, -1) !== "\n") {
                        return $dataLength;
                    }
                    $data = $respTemp;
                    $respTemp = '';
                }
            }

            if (empty($wordArr)) {
                $wordArr = $this->parseData($data);
            }
            if ($replyCallback && !empty($wordArr)) {
                foreach ($wordArr as $word) {
                    $replyCallback($ch, $word);
                }
            }
            return $dataLength;
        };

        $questions = $this->makeQuestions();
        if (in_array(self::$ai, ['wenxin', 'wenxin4', 'minimax'])) {
            $result = $SDK->sendText($questions, self::$systemPrompt, $respFunc);
        } elseif (self::$ai == 'xunfei') {
            $result = $SDK->sendText($questions, $replyCallback, $errorCallback);
        } else {
            $result = $SDK->sendText($questions, $respFunc);
        }

        if (!empty($result) && !empty($result['errno']) && $errorCallback) {
            $errorCallback($result);
        }
    }

    /**
     * @param $msgs
     * @return array
     * 处理关联上文，防止过长
     */
    private function makeRelations($msgs)
    {
        if (strpos(self::$message, '请仅在以下内容里搜索答案') !== false) {
            return [];
        }
        $str = self::$systemPrompt . self::$message;
        foreach ($msgs as $msg) {
            $str .= $msg['message'] . $msg['response'];
        }
        if (calcTokens($str) > self::$maxRelationLength) {
            array_pop($msgs);
            if (count($msgs) > 0) {
                return $this->makeRelations($msgs);
            }
            return [];
        }
        return array_reverse($msgs);
    }

    /**
     * @return array
     * 组装问题数组
     */
    private function makeQuestions()
    {
        $questions = [];
        // 前置指令
        if (self::$systemPrompt) {
            if (in_array(self::$ai, ['openai3', 'openai4', 'azure_openai3', 'azure_openai4', 'lxai', 'tongyi'])) {
                $questions[] = [
                    'role' => 'system',
                    'content' => self::$systemPrompt
                ];
            } elseif (!in_array(self::$ai, ['wenxin', 'wenxin4', 'minimax'])) {
                $questions[] = [
                    'role' => 'user',
                    'content' => self::$systemPrompt
                ];
                $questions[] = [
                    'role' => 'assistant',
                    'content' => '好的，我将严格按照你的要求扮演角色。'
                ];
            }
        }
        // 历史消息
        $relationMsgs = $this->makeRelations(self::$relationMsgs);
        foreach ($relationMsgs as $msg) {
            $questions[] = [
                'role' => 'user',
                'content' => $msg['message']
            ];
            $questions[] = [
                'role' => 'assistant',
                'content' => $msg['response']
            ];
        }
        // 当前提问
        $questions[] = [
            'role' => 'user',
            'content' => self::$message
        ];

        return $questions;
    }

    /**
     * @param $content
     * @return array
     * 解析返回的数据，返回文字数组的形式：['你’, '好！']
     */
    private function parseData($content)
    {
        $wordArr = [];
        switch (self::$ai) {
            case 'openai3':
            case 'openai4':
            case 'azure_openai3':
            case 'azure_openai4':
            case 'lxai':
            case 'claude2':
                $wordArr = $this->openaiParseData($content);
                break;
            case 'wenxin':
            case 'wenxin4':
                $wordArr = $this->wenxinParseData($content);
                break;
            case 'tongyi':
                $wordArr = $this->tongyiParseData($content);
                break;
            case 'hunyuan':
                $wordArr = $this->hunyuanParseData($content);
                break;
            case 'zhipu':
                $wordArr = $this->zhipuParseData($content);
                break;
            case 'minimax':
                $wordArr = $this->minimaxParseData($content);
                break;
        }
        return $wordArr;
    }

    private function openaiParseData($content)
    {
        $content = trim($content);
        $rows = explode("\n", $content);
        $result = [];
        $char = '';
        foreach ($rows as $data) {
            $is_end = false;
            if (strpos($data, 'data: [DONE]') !== false) {
                $is_end = true;
            } else {
                $data = str_replace('data: {', '{', $data);
                $data = rtrim($data, "\n\n");

                // 有可能一次返回多条data: {}
                if (strpos($data, "}\n\n{") !== false) {
                    $arr = explode("}\n\n{", $data);
                    $data = '{' . $arr[1];
                }

                $data = @json_decode($data, true);
                if (!is_array($data)) {
                    continue;
                }
                if (isset($data['choices'])) {
                    $finish_reason = null;
                    if (isset($data['choices']['0']['finish_reason'])) {
                        $finish_reason = $data['choices']['0']['finish_reason'];
                    } elseif (isset($data['finish_reason'])) {
                        $finish_reason = $data['finish_reason'];
                    }
                    if ($finish_reason == 'stop') {
                        $is_end = true;
                    } elseif ($finish_reason == 'length') {
                        $char = 'data: [CONTINUE]';
                    } elseif (isset($data['choices']['0']['delta']['content'])) {
                        $char = $data['choices']['0']['delta']['content'];
                    }
                }
            }
            if ($char !== '') {
                $result[] = $char;
                $char = '';
            }
            if ($is_end) {
                $result[] = 'data: [DONE]';
            }
        }

        return $result;
    }

    private function wenxinParseData($content)
    {
        $content = trim($content);
        $rows = explode("\n", $content);
        $result = [];
        foreach ($rows as $data) {
            $is_end = false;

            $data = str_replace('data: {', '{', $data);
            $data = rtrim($data, "\n\n");

            // 有可能一次返回多条data: {}
            if (strpos($data, "}\n\n{") !== false) {
                $arr = explode("}\n\n{", $data);
                $data = '{' . $arr[1];
            }

            $data = @json_decode($data, true);
            if (!is_array($data)) {
                continue;
            }
            if (isset($data['result'])) {
                $char = $data['result'];
                if ($data['is_end']) {
                    $is_end = true;
                }
                if ($data['need_clear_history']) {
                    $is_end = true;
                    $char = '敏感内容，无法输出。';
                }
            }
            if (isset($char)) {
                $result[] = $char;
            }
            if ($is_end) {
                $result[] = 'data: [DONE]';
            }
        }

        return $result;
    }

    private function tongyiParseData($content)
    {
        $content = trim($content);
        $rows = explode("\n", $content);
        $result = [];
        foreach ($rows as $data) {
            if (strpos($data, 'data:{') === false) {
                continue;
            }
            $is_end = false;

            $data = str_replace('data:{', '{', $data);
            $data = rtrim($data, "\n\n");
            $data = @json_decode($data, true);
            if (!is_array($data) || empty($data['output'])) {
                continue;
            }

            if (!empty($data['output']['text'])) {
                $result[] = $data['output']['text'];
            }
            if ($data['output']['finish_reason'] == 'stop') {
                $is_end = true;
                $result[] = 'data: [DONE]';
            }
        }

        return $result;
    }

    private function hunyuanParseData($content)
    {
        $content = trim($content);
        $rows = explode("\n", $content);
        $result = [];
        $char = '';
        foreach ($rows as $data) {
            $is_end = false;
            if (strpos($data, 'data: [DONE]') !== false) {
                $is_end = true;
            } else {
                $data = str_replace('data: {', '{', $data);
                $data = rtrim($data, "\n\n");

                $data = @json_decode($data, true);
                if (!is_array($data)) {
                    continue;
                }

                if (isset($data['error'])) {
                    $char = $data['error']['message'];
                    $is_end = true;
                } elseif (isset($data['choices'])) {
                    $finish_reason = null;
                    if (isset($data['choices']['0']['finish_reason'])) {
                        $finish_reason = $data['choices']['0']['finish_reason'];
                    } elseif (isset($data['finish_reason'])) {
                        $finish_reason = $data['finish_reason'];
                    }
                    if ($finish_reason == 'stop') {
                        $is_end = true;
                    } elseif ($finish_reason == 'length') {
                        $char = 'data: [CONTINUE]';
                    } elseif (isset($data['choices']['0']['delta']['content'])) {
                        $char = $data['choices']['0']['delta']['content'];
                    }
                }
            }
            if ($char !== '') {
                $result[] = $char;
                $char = '';
            }
            if ($is_end) {
                $result[] = 'data: [DONE]';
            }
        }

        return $result;
    }

    private function minimaxParseData($content)
    {
        $content = trim($content);
        $rows = explode("\n", $content);
        $result = [];
        foreach ($rows as $data) {
            $is_end = false;

            $data = str_replace('data: {', '{', $data);
            $data = rtrim($data, "\n\n");
            $data = @json_decode($data, true);
            if (!is_array($data)) {
                continue;
            }
            if (isset($data['choices'])) {
                $finish_reason = null;
                if (isset($data['choices']['0']['finish_reason'])) {
                    $finish_reason = $data['choices']['0']['finish_reason'];
                }
                if ($finish_reason == 'stop') {
                    $is_end = true;
                } elseif ($finish_reason == 'length') {
                    $char = 'data: [CONTINUE]';
                } elseif (isset($data['choices']['0']['messages'][0]['text'])) {
                    $char = $data['choices']['0']['messages'][0]['text'];
                }
            }

            if (isset($char)) {
                $result[] = $char;
            }
            if ($is_end) {
                $result[] = 'data: [DONE]';
            }
        }

        return $result;
    }

    private function zhipuParseData($content)
    {
        $rows = explode("\n", $content);
        $result = [];
        foreach ($rows as $data) {
            if ($data == 'event:finish') {
                $result[] = 'data: [DONE]';
                return $result;
            } else {
                if (strpos($data, 'data:') === false) {
                    continue;
                }
                $data = str_replace('data:', '', $data);
                if ($data !== '') {
                    $result[] = $data;
                } else {
                    $result[] = "\n";
                }
            }
        }
        return $result;
    }

    /**
     * @param $data
     * @return array|void|null
     * 解析报错信息
     */
    private function parseError($data)
    {
        if (strpos($data, '{') === false) {
            return null;
        }
        $data = @json_decode($data);
        if (empty($data)) {
            return null;
        }
        $errorMsg = json_encode($data);
        if (in_array(self::$ai, ['openai3', 'openai4', 'azure_openai3', 'azure_openai4', 'lxai', 'tongyi'])) {
            if (isset($data->error)) {
                if (isset($data->error->code) && $data->error->code == 'invalid_api_key') {
                    $errorMsg = 'invalid_api_key';
                } else {
                    $errorMsg = $data->error->message;
                }
            } elseif (isset($data->object) && $data->object == 'error') {
                // api2d
                $errorMsg = $data->message;
            }
        } elseif (self::$ai == 'wenxin' || self::$ai == 'wenxin4') {
            if (isset($data->error_code)) {
                $errorMsg = $data->error_msg;
            }
            if (!empty($data->need_clear_history) && !empty($data->result)) {
                $errorMsg = $data->result;
            }
        } elseif (self::$ai == 'zhipu') {
            if (isset($data->code)) {
                $errorMsg = $data->msg;
            }
        } elseif (self::$ai == 'minimax') {
            if (empty($data->choices) && !empty($data->base_resp)) {
                $errorMsg = $data->base_resp->status_msg;
            }
        } elseif (self::$ai == 'claude2') {
            if (isset($data->error)) {
                $errorMsg = $data->error->message;
            }
        }
        $error = $this->formatError($errorMsg);

        if ($error) {
            // 如果是key池的key出现错误，则继续试用下一个key
            if ($error['level'] == 'error') {
                $this->setKeyStop($error['message']);
                $this->sendText();
                exit;
            } elseif (strpos($error['message'], 'maximum context length') !== false) {
                /*$this->sendText(true);
                exit;*/
            }
        }

        return $error;
    }

    private function formatError($errorMsg)
    {
        if (empty($errorMsg)) {
            return null;
        }
        $level = 'warning';
        if (strpos($errorMsg, 'invalid_api_key') !== false) {
            $level = 'error';
            $errorMsg = 'key不正确';
        } elseif (strpos($errorMsg, 'Incorrect API key provided') !== false) {
            $level = 'error';
            $errorMsg = 'key不正确。' . $errorMsg;
        } elseif (strpos($errorMsg, 'deactivated account') !== false) {
            $level = 'error';
            $errorMsg = 'key账号被封。' . $errorMsg;
        } elseif (strpos($errorMsg, 'has been deactivated') !== false) {
            $level = 'error';
            $errorMsg = 'key已停用。' . $errorMsg;
        } elseif (strpos($errorMsg, 'exceeded your current quota') !== false) {
            $level = 'error';
            $errorMsg = 'key余额不足。' . $errorMsg;
        } elseif (strpos($errorMsg, 'Your account is not active') !== false) {
            $level = 'error';
            $errorMsg = '账号已停用。' . $errorMsg;
        } elseif (strpos($errorMsg, 'thus not supported') !== false) {
            $level = 'error';
            $errorMsg = 'key不支持此模型。' . $errorMsg;
        } elseif (strpos($errorMsg, 'Rate limit reached') !== false) {
            $errorMsg = '达到接口频率上限，请稍后重试';
        } elseif (strpos($errorMsg, 'maximum context length') !== false) {
            $errorMsg = '内容超长，请缩减后提交';
        } elseif (strpos($errorMsg, 'Not enough point') !== false) {
            $level = 'error';
            $errorMsg = 'key余额不足。' . $errorMsg;
        } elseif (strpos($errorMsg, 'bad forward key') !== false) {
            $level = 'error';
            $errorMsg = 'key不正确。' . $errorMsg;
        }

        return [
            'level' => $level,
            'message' => $errorMsg
        ];
    }

    /**
     * @param $text
     * @return array|mixed
     * 获取文本向量
     */
    public function getEmbedding($text)
    {
        $result = '';
        try {
            $SDK = $this->initAiSDK();
            $result = $SDK->getEmbedding($text);
        } catch (\Exception $e) {

        }
        return $result;
    }

    /**
     * 从key池里取回一个key
     */
    private function getApiKey($type)
    {
        $rs = Db::name('keys')
            ->where([
                ['site_id', '=', self::$site_id],
                ['type', '=', $type],
                ['state', '=', 1]
            ])
            ->order('last_time asc, id asc')
            ->find();
        if (!$rs) {
            $this->throwError('key已用尽，请等待平台处理');
        }
        Db::name('keys')
            ->where('id', $rs['id'])
            ->update([
                'last_time' => time()
            ]);

        self::$keyType = $type;
        self::$apiKey = $rs['key'];
    }

    /**
     * key出错时，停止key
     */
    private function setKeyStop($errorMsg)
    {
        if ($errorMsg) {
            Db::name('keys')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['type', '=', self::$keyType],
                    ['key', '=', self::$apiKey]
                ])
                ->update([
                    'state' => 0,
                    'stop_reason' => $errorMsg
                ]);
        }
    }

    private function throwError($errmsg)
    {
        throw new \Exception($errmsg);
    }
}
