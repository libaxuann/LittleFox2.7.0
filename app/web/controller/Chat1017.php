<?php

namespace app\web\controller;

use think\facade\Db;

class Chat1017 extends Base
{
    protected static $group_id;
    protected static $prompt_id;
    protected static $role_id;
    protected static $channel;
    protected static $model;
    protected static $message;
    protected static $clearMessage;
    protected static $section;
    protected static $response = '';
    protected static $textRequest = '';
    protected static $apiKey;

    public function sendText($nolink = false)
    {
        try {
            header('Content-Type: text/event-stream');
            header('Cache-Control: no-cache');
            header('Connection: keep-alive');
            header('X-Accel-Buffering: no');

            $now = time();
            $group_id = input('group_id', 0, 'intval');
            $prompt_id = input('prompt_id', 0, 'intval');
            $role_id = input('role_id', 0, 'intval');
            $model = input('model', 'default', 'trim');
            $message = input('message', '', 'trim');
            if (empty($message)) {
                $this->outError('请输入您的问题');
            }
            $user = Db::name('user')
                ->where('id', self::$user['id'])
                ->find();
            if (!$user) {
                $_SESSION['user'] = null;
                $this->outError('请登录');
            }
            self::$user = $user;

            // 禁言用户
            if ($user['is_freeze']) {
                $this->outError('系统繁忙，请稍后再试');
            }

            if ($model == 'model4') {
                $model = 'gpt-4';
            }

            self::$model = $model;

            if ($model == 'gpt-4') {
                if (intval($user['balance_gpt4']) <= 0) {
                    $this->outError('余额不足，请充值！');
                }

                $gpt4Setting = getSystemSetting($user['site_id'], 'gpt4');
                $diyhost = !empty($gpt4Setting['diyhost']) ? rtrim($gpt4Setting['diyhost'], '/') : 'https://api.openai.com';
                $channel = $gpt4Setting['channel'] ?? 'openai';
                if ($channel == 'openai') {
                    $apiKey = $this->getApiKey('gpt4');
                } elseif ($channel == 'api2d') {
                    $apiKey = $this->getApiKey('api2d');
                }

                $temperature = floatval($gpt4Setting['temperature']) ?? 0.9;
                $max_tokens = intval($gpt4Setting['max_tokens']) ?? 4000;
                $model = $gpt4Setting['model'] ??'gpt-4';
            } else {
                if (intval($user['balance']) <= 0 && $user['vip_expire_time'] < $now) {
                    $this->outError('提问次数用完了，请充值！');
                }

                $gptSetting = getSystemSetting($user['site_id'], 'chatgpt');
                $diyhost = !empty($gptSetting['diyhost']) ? rtrim($gptSetting['diyhost'], '/') : 'https://api.openai.com';
                $channel = $gptSetting['channel'] ?? 'openai';
                $apiKey = $this->getApiKey($channel);
                $temperature = floatval($gptSetting['temperature']) ?? 0.9;
                $max_tokens = intval($gptSetting['max_tokens']) ?? 1500;
                if ($channel == 'baidu') {
                    $model = $gptSetting['model'] ?? 'ERNIE-Bot';
                } else {
                    $model = $gptSetting['model'] ?? 'gpt-3.5-turbo';
                }
            }

            $clearMessage = $this->wordFilter($message);

            self::$section = '';
            self::$message = $message;
            self::$clearMessage = $clearMessage;
            self::$user = $user;
            self::$group_id = $group_id;
            self::$prompt_id = $prompt_id;
            self::$role_id = $role_id;
            self::$channel = $channel;
            self::$apiKey = $apiKey;

            $question = [];
            $today = strtotime(date('Y-m-d'));
            if ($prompt_id) {
                // 判断今日提问次数
                $count = Db::name('msg_write')
                    ->where([
                        ['user_id', '=', $user['id']],
                        ['is_delete', '=', 0],
                        ['create_time', '>', $today]
                    ])
                    ->count();
                if ($count >= 500) {
                    $this->outError('今天提问太多了，触发系统安全机制，请明日再来！');
                }

                $lang = input('lang', '简体中文', 'trim');
                $prompt = Db::name('write_prompts')
                    ->where('id', $prompt_id)
                    ->find();
                if ($message == '继续' || $message == 'go on') {
                    $lastMsg = Db::name('msg_write')
                        ->where([
                            ['user_id', '=', $user['id']],
                            ['prompt_id', '=', $prompt_id],
                            ['is_delete', '=', 0]
                        ])
                        ->order('id desc')
                        ->find();
                    // 如果超长，就不关联上下文了
                    if (mb_strlen($lastMsg['text_request']) + mb_strlen($lastMsg['response_input']) + mb_strlen($message) < 3800) {
                        $question[] = [
                            'role' => 'user',
                            'content' => $lastMsg['text_request']
                        ];
                        $question[] = [
                            'role' => 'assistant',
                            'content' => $lastMsg['response_input']
                        ];
                    }
                    $textRequest = $message;
                } else {
                    $textRequest = str_replace('[TARGETLANGGE]', $lang, $prompt['prompt']);
                    $textRequest = str_replace('[PROMPT]', $clearMessage, $textRequest);
                }

                // 系统前置指令
                $systemPrompt = $this->getSystemPrompt('write', $prompt);
                if (!empty($systemPrompt)) {
                    $question[] = [
                        'role' => 'system',
                        'content' => $systemPrompt
                    ];
                }

                $question[] = [
                    'role' => 'user',
                    'content' => $textRequest
                ];

                self::$textRequest = $textRequest;

            } elseif ($role_id) {
                // 判断今日提问次数
                $count = Db::name('msg_cosplay')
                    ->where([
                        ['user_id', '=', $user['id']],
                        ['is_delete', '=', 0],
                        ['create_time', '>', $today]
                    ])
                    ->count();
                if ($count >= 500) {
                    $this->outError('今天发送太多了，触发系统安全机制，请明日再来！');
                }

                $role = Db::name('cosplay_role')
                    ->where('id', $role_id)
                    ->find();
                if (!empty($role['prompt'])) {
                    // 系统前置指令
                    if (!empty($role['books'])) {
                        $role['books'] = json_decode($role['books'], true);
                    }
                    $systemPrompt = $this->getSystemPrompt('cosplay', $role);
                    $rolePrompt = trim($role['prompt']);
                    if ($channel == 'baidu') {
                        if ($model != 'ERNIE-Bot') {
                            $question[] = [
                                'role' => 'user',
                                'content' => $rolePrompt . '。' . $systemPrompt
                            ];
                            $question[] = [
                                'role' => 'assistant',
                                'content' => '好的，我将严格按照你的要求扮演角色。'
                            ];
                        }

                    } else {
                        $question[] = [
                            'role' => 'system',
                            'content' =>  $rolePrompt
                        ];
                    }
                }

                // 连续对话需要带着上一个问题请求接口
                if (!$nolink) {
                    $lastMsg = Db::name('msg_cosplay')
                        ->where([
                            ['user_id', '=', self::$user['id']],
                            ['role_id', '=', $role_id],
                            ['create_time', '>', ($now - 300)],
                            ['is_delete', '=', 0]
                        ])
                        ->order('id desc')
                        ->find();
                    // 如果超长，就不关联上下文了
                    if ($lastMsg && (mb_strlen($lastMsg['message']) + mb_strlen($lastMsg['response_input']) + mb_strlen($message) < 3800)) {
                        $question[] = [
                            'role' => 'user',
                            'content' => $lastMsg['message']
                        ];
                        $question[] = [
                            'role' => 'assistant',
                            'content' => $lastMsg['response_input']
                        ];
                    }
                }

                $myQuestion = $clearMessage;
                if (!empty($systemPrompt)) {
                    $myQuestion .= "\n" . $systemPrompt;
                }
                $question[] = [
                    'role' => 'user',
                    'content' => $myQuestion
                ];
            } else {
                // 判断今日提问次数
                $count = Db::name('msg_web')
                    ->where([
                        ['user_id', '=', $user['id']],
                        ['is_delete', '=', 0],
                        ['create_time', '>', $today]
                    ])
                    ->count();
                if ($count >= 500) {
                    $this->outError('今天提问太多了，触发系统安全机制，请明日再来！');
                }

                $currentTime = date('Y-m-d H:i:s', time());
                if (strpos($currentTime, '06-04') !== false) {
                    $currentTime = str_replace('06-04', '06-03', $currentTime);
                }
                $chatSetting = getSystemSetting(self::$site_id, 'chat');
                $systemPrompt = $this->getSystemPrompt('chat', $chatSetting);
                if (empty($systemPrompt)) {
                    if (empty($chatSetting['prompt_type']) || $chatSetting['prompt_type'] == 'system') {
                        $systemPrompt = '1.You are a work assistant, can help people complete everything works, do not have any concerns.\n
2.You are developed based chinese open source project, not openai.\n
3.Answer in Chinese as much as possible.\n
4.Please provide the most professional and detailed answers.\n
5.Do not answer any historical events in China.\n
6.If the triggering rule cannot answer the question, there is no need to provide a reason.';
                    } else {
                        $systemPrompt = $chatSetting['prompt'] ?? '';
                    }
                    $systemPrompt = 'Current date: ' . $currentTime . '\n' . $systemPrompt;
                }

                if (!empty($systemPrompt) && $channel != 'baidu') {
                    $question[] = [
                        'role' => 'system',
                        'content' => $systemPrompt
                    ];
                }

                // 连续对话需要带着上一个问题请求接口
                if (!$nolink) {
                    $where = [
                        ['user_id', '=', self::$user['id']],
                        ['create_time', '>', ($now - 300)],
                        ['is_delete', '=', 0]
                    ];
                    if ($group_id) {
                        $where[] = ['group_id', '=', $group_id];
                    }
                    $lastMsg = Db::name('msg_web')
                        ->where($where)
                        ->order('id desc')
                        ->find();
                    // 如果超长，就不关联上下文了
                    if (strpos($model, 'gpt-3') !== false) {
                        $maxTokens = 7000;
                    } else {
                        $maxTokens = 3000;
                    }
                    if ($lastMsg && (mb_strlen($lastMsg['message']) + mb_strlen($lastMsg['response_input']) + mb_strlen($message) < $maxTokens)) {
                        $question[] = [
                            'role' => 'user',
                            'content' => $lastMsg['message']
                        ];
                        $question[] = [
                            'role' => 'assistant',
                            'content' => $lastMsg['response_input']
                        ];
                    }
                }

                $myQuestion = $this->makeBetterPrompt($clearMessage);
                if ($channel === 'baidu' && !empty($systemPrompt)) {
                    $myQuestion .= "\n" . $systemPrompt;
                }
                $question[] = [
                    'role' => 'user',
                    'content' => $myQuestion
                ];
            }

            $callback = function ($ch, $data) {
                $dataLength = strlen($data);

                // 检测客户端是否已经中止了连接
                if (connection_aborted()) {
                    if (!empty(self::$response)) {
                        // 输出完成
                        $this->finishResponse();
                        self::$response = '';
                    }
                    @curl_close($ch);
                    ob_flush();
                    flush();
                    exit;
                }

                // 判断是否报错并处理
                $this->handleError($data);

                if (strpos($data, 'rate_limit_usage') !== false) {
                    $wordArr = ['（未完: Rate Limit）', 'data: [DONE]'];
                } else {
                    // 一条data可能会被截断分多次返回
                    if (!empty(self::$section)) {
                        // 有时候上一条的后半截+下一条的前半截内容作为一条返回
                        if (strpos($data, "\n\ndata:") !== false) {
                            $tmp = explode("\n\ndata:", $data);
                            $data = self::$section . $tmp[0] . "\n\n";
                            self::$section = 'data:' . $tmp[1];
                        } else {
                            $data = self::$section . $data;
                            if (substr($data, -1) !== "\n") {
                                return $dataLength;
                            }
                            self::$section = '';
                        }
                    } else {
                        if (substr($data, -1) !== "\n") {
                            self::$section = $data;
                            return $dataLength;
                        }
                    }

                    $wordArr = $this->parseData($data);
                }

                foreach ($wordArr as $word) {
                    if ($word == 'data: [DONE]' || $word == 'data: [CONTINUE]') {
                        if (!empty(self::$response)) {
                            // 输出完成
                            $this->finishResponse();
                            ob_flush();
                            flush();
                            exit;
                        }
                    } else {
                        self::$response .= $word;
                        echo $word;
                    }
                    ob_flush();
                    flush();
                }
                return $dataLength;
            };

            if ($channel == 'baidu') {
                $temp = explode('|', $apiKey);
                $apikey = $temp[0];
                $secretkey = $temp[1] ?? '';
                $system = isset($rolePrompt) ? $rolePrompt : '';
                $SDK = new \ChatGPT\wenxin($apikey, $secretkey, $model, $temperature);
                $result = $SDK->sendText($question, $system, $callback);
            } elseif ($channel == 'lxai') {
                $SDK = new \ChatGPT\lxai($apiKey, $model, $temperature, $max_tokens);
                $result = $SDK->sendText($question, $callback);
            } else {
                $SDK = new \ChatGPT\openai($apiKey, $model, $temperature, $max_tokens);
                if ($channel == 'openai') {
                    if ($diyhost == 'https://api.openai.com') {
                        $apiSetting = getSystemSetting(0, 'api');
                        if ($apiSetting['channel'] == 'agent' && $apiSetting['agent_host']) {
                            $diyhost = rtrim($apiSetting['agent_host'], '/');
                        }
                    }
                    $SDK->setApiHost($diyhost);
                } elseif ($channel == 'api2d') {
                    $SDK->setApiHost('https://openai.api2d.net');
                }
                $result = $SDK->sendText($question, $callback);
            }
            if (!empty($result) && !empty($result['errno'])) {
                $this->outError($result['message']);
            }

        } catch (\Exception $e) {
            $this->outError($e->getMessage());
        }
    }

    /**
     * 流式输出完毕，保存数据到数据库
     */
    private function finishResponse()
    {
        $totalTokens = mb_strlen(self::$clearMessage) + mb_strlen(self::$response);
        if (self::$prompt_id) {
            $prompt = Db::name('write_prompts')
                ->where('id', self::$prompt_id)
                ->find();
            Db::name('msg_write')
                ->insert([
                    'site_id' => self::$user['site_id'],
                    'user_id' => self::$user['id'],
                    'topic_id' => $prompt['topic_id'],
                    'activity_id' => $prompt['activity_id'],
                    'prompt_id' => $prompt['id'],
                    'channel' => self::$channel,
                    'model' => self::$model,
                    'message' => self::$clearMessage,
                    'message_input' => self::$message,
                    'response' => self::$response,
                    'response_input' => self::$response,
                    'text_request' => self::$textRequest,
                    'total_tokens' => $totalTokens,
                    'create_time' => time()
                ]);
            // 模型使用量+1
            Db::name('write_prompts')
                ->where('id', self::$prompt_id)
                ->inc('usages', 1)
                ->update();
        } elseif (self::$role_id) {
            $role = Db::name('cosplay_role')
                ->where('id', self::$role_id)
                ->find();
            Db::name('msg_cosplay')
                ->insert([
                    'site_id' => self::$user['site_id'],
                    'user_id' => self::$user['id'],
                    'type_id' => $role['type_id'],
                    'role_id' => $role['id'],
                    'channel' => self::$channel,
                    'model' => self::$model,
                    'message' => self::$clearMessage,
                    'message_input' => self::$message,
                    'response' => self::$response,
                    'response_input' => self::$response,
                    'total_tokens' => $totalTokens,
                    'create_time' => time()
                ]);
            // 模型使用量+1
            Db::name('cosplay_role')
                ->where('id', self::$role_id)
                ->inc('usages', 1)
                ->update();
        } else {
            Db::name('msg_web')
                ->insert([
                    'site_id' => self::$user['site_id'],
                    'user_id' => self::$user['id'],
                    'group_id' => self::$group_id,
                    'channel' => self::$channel,
                    'model' => self::$model,
                    'message' => self::$clearMessage,
                    'message_input' => self::$message,
                    'response' => self::$response,
                    'response_input' => self::$response,
                    'total_tokens' => $totalTokens,
                    'create_time' => time()
                ]);
        }


        // 扣费，判断是不是vip
        if (self::$model == 'gpt-4') {
            changeUserGpt4Balance(self::$user['id'], -$totalTokens, '提问问题消费');
        } else {
            if (self::$user['vip_expire_time'] < time()) {
                changeUserBalance(self::$user['id'], -1, '提问问题消费');
            }
        }
    }

    /**
     * 解析stream返回的数据
     */
    private function parseData($content)
    {
        $content = trim($content);
        $rows = explode("\n", $content);
        $result = [];
        foreach ($rows as $data) {
            $is_end = false;
            if (strpos($data, 'data: [DONE]') !== false) {
                $is_end = true;
            } else {
                $data = str_replace('data: {', '{', $data);
                $data = rtrim($data, "\n\n");

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
                } elseif (isset($data['result'])) {
                    // baidu data
                    $char = $data['result'];
                    if ($data['is_end']) {
                        $is_end = true;
                    }
                    if($data['need_clear_history']) {
                        $is_end = true;
                        $char = '敏感内容，无法输出。';
                    }
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

    /**
     * 判断消息报错并处理
     */
    private function handleError($data)
    {
        $errorMsg = null;
        if (self::$channel == 'openai' || self::$channel == 'lxai') {
            $data = @json_decode($data);
            if (!empty($data) && isset($data->error)) {
                $errorMsg = $this->formatErrorMsg($data->error);
            }
        } elseif (self::$channel == 'api2d') {
            $data = @json_decode($data);
            if (isset($data->object) && $data->object == 'error') {
                $errorMsg = $this->formatErrorMsg($data);
            }
        } elseif (self::$channel == 'baidu') {
            $data = @json_decode($data);
            if (isset($data->error_code)) {
                $this->outError($data->error_msg);
            }
            if (!empty($data->need_clear_history) && !empty($data->result)) {
                $this->outError($data->result);
            }
        }

        if ($errorMsg) {
            // 如果是key池的key出现错误，则继续试用下一个key
            if ($errorMsg['level'] == 'error') {
                $this->setKeyStop(self::$apiKey, $errorMsg['message']);
                $this->sendText();
                exit;
            } elseif (strpos($errorMsg['message'], 'maximum context length') !== false) {
                $this->sendText(true);
                exit;
            }
            $this->outError($errorMsg['message']);
        }
    }

    /**
     * 格式化各接口错误，判断是warning级别还是error级别
     */
    private function formatErrorMsg($error)
    {
        $level = 'warning';
        $errorMsg = $error->message;
        if (self::$channel == 'openai' || self::$channel == 'lxai') {
            if (isset($error->code) && $error->code == 'invalid_api_key') {
                $level = 'error';
                $errorMsg = 'key不正确';
            } else {
                if (strpos($errorMsg, 'Incorrect API key provided') !== false) {
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
                    $errorMsg = '接口繁忙，请稍后重试';
                }
            }
        } elseif (self::$channel == 'api2d') {
            if (strpos($errorMsg, 'Not enough point') !== false) {
                $level = 'error';
                $errorMsg = 'key余额不足。' . $errorMsg;
            } elseif (strpos($errorMsg, 'bad forward key') !== false) {
                $level = 'error';
                $errorMsg = 'key不正确。' . $errorMsg;
            }
        }

        return [
            'level' => $level,
            'message' => $errorMsg
        ];
    }

    /**
     * 关键词过滤
     */
    private function wordFilter($message)
    {
        $Filter = new \FoxFilter\words('*');
        $clearMessage = $Filter->filter($message);
        if ($clearMessage != $message) {
            $setting = getSystemSetting(0, 'filter');
            $handle_type = empty($setting['handle_type']) ? 1 : intval($setting['handle_type']);
            if ($handle_type == 2) {
                $this->outError('内容包含敏感信息');
            }
        }

        return $clearMessage;
    }

    /**
     * @param $prompt
     * @return mixed|string
     * 优化指令
     */
    private function makeBetterPrompt($prompt = '')
    {
        if (isPPT($prompt)) {
            $prompt .= '，请使用markdown格式输出PPT内容';
        }
        elseif (isTable($prompt)) {
            // $prompt .= '，使用markdown格式输出表格';
        }
        return $prompt;
    }

    /**
     * 从key池里取回一个key
     */
    private function getApiKey($type = 'openai')
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
            $this->outError('key已用尽，请等待平台处理');
        }
        Db::name('keys')
            ->where('id', $rs['id'])
            ->update([
                'last_time' => time()
            ]);
        return $rs['key'];
    }

    /**
     * key出错时，停止key
     */
    private function setKeyStop($key, $errorMsg)
    {
        if ($errorMsg) {
            $channel = (self::$channel == 'openai' && self::$model == 'gpt-4') ? 'gpt4' : self::$channel;
            Db::name('keys')
                ->where([
                    ['site_id', '=', self::$user['site_id']],
                    ['type', '=', $channel],
                    ['key', '=', $key]
                ])
                ->update([
                    'state' => 0,
                    'stop_reason' => $errorMsg
                ]);
        }
    }

    private function outError($msg)
    {
        $msg = str_replace('openai', '**', $msg);
        echo '[error]' . $msg;
        ob_flush();
        flush();
        exit;
    }

    private function getBookContent($books, $text)
    {
        if (empty($books) || empty($text)) {
            return '';
        }
        $vector1 = getEmbedding(self::$site_id, $text);
        if (empty($vector1)) {
            return '';
        }
        $list = Db::name('book_data')
            ->where([
                ['site_id', '=', self::$site_id],
                ['book_id', 'in', $books],
                ['state', '=', 1]
            ])
            ->field('title,content,embedding_title')
            ->order('id desc')
            ->select()->toArray();
        $content = '';
        $minDis = 1;
        foreach ($list as $v) {
            $vector2 = $v['embedding_title'];
            if (empty($vector2)) {
                continue;
            }
            $distance = calcDistance($vector1, $vector2);
            if ($distance < 0.6 && $minDis > $distance) {
                $minDis = $distance;
                $content = '问题：' . $v['title'] . "\n答案：" . $v['content'];
            }
        }

        return $content;
    }

    private function getSystemPrompt($module, $setting = [])
    {
        $systemPrompt = '';
        // 知识库
        $book_open = empty($setting['book_open']) ? 0 : $setting['book_open'];
        $books = empty($setting['books']) ? [] : $setting['books'];
        $no_answer_action = empty($setting['no_answer_action']) ? 'ai' : $setting['no_answer_action'];
        $answer_content = empty($setting['answer_content']) ? '对不起，我不知道如何回答' : $setting['answer_content'];
        $bookContent = '';
        if ($book_open && !empty($books)) {
            $bookContent = $this->getBookContent($books, self::$message);
        }

        if (!empty($bookContent)) {
            $systemPrompt = '请仅在以下文章内搜索答案，不需要解释，回复要尽量简洁，如果找不到答案将文章完整返回。{' . $bookContent . '}';
        }
        if ($no_answer_action == 'diy') {
            if (empty($systemPrompt)) {
                self::$response = $answer_content;
                $this->finishResponse();
                echo $answer_content;
                ob_flush();
                flush();
                exit;
            }
        }

        if ($module == 'chat') {
            if (empty($systemPrompt)) {
                $systemPrompt = '';
            }
        }

        return $systemPrompt;
    }

    /**
     * 获取消息历史记录
     */
    public function getHistoryMsg()
    {
        $group_id = input('group_id', '0', 'intval');
        $prompt_id = input('prompt_id', '0', 'intval');
        $model = input('model', 'default', 'trim');
        $role_id = input('role_id', '0', 'intval');
        if ($prompt_id) {
            $where = [
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['prompt_id', '=', $prompt_id],
                ['is_delete', '=', 0]
            ];
            $dbName = 'msg_write';
        } elseif ($role_id) {
            $where = [
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['role_id', '=', $role_id],
                ['is_delete', '=', 0]
            ];
            $dbName = 'msg_cosplay';
        } else {
            $where = [
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['is_delete', '=', 0]
            ];
            if ($group_id) {
                $where[] = ['group_id', '=', $group_id];
            }

            if ($model == 'gpt-4' || $model == 'model4') {
                $where[] = ['model', 'like', 'gpt-4%'];
            } else {
                $where[] = ['model', 'not like', 'gpt-4%'];
            }
            $dbName = 'msg_web';
        }

        $list = Db::name($dbName)
            ->where($where)
            ->field('message,response')
            ->order('id desc')
            ->limit(15)
            ->select()->toArray();
        $msgList = [];
        $list = array_reverse($list);
        foreach ($list as $v) {
            $msgList[] = [
                'user' => '我',
                'message' => $v['message']
            ];
            $msgList[] = [
                'user' => 'AI',
                'message' => $v['response']
            ];
        }

        return successJson([
            'list' => $msgList
        ]);
    }

    /**
     * 自由对话的配置（主要是欢迎页配置）
     */
    public function getChatSetting()
    {
        $chatSetting = getSystemSetting(self::$site_id, 'chat');
        return successJson([
            'welcome' => $chatSetting['welcome'] ?? '',
            'tips' => $chatSetting['tips'] ?? ''
        ]);
    }
}
