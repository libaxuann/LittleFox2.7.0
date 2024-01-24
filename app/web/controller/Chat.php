<?php

namespace app\web\controller;

use think\facade\Db;

class Chat extends Base
{
    protected static $ai = ''; // AI通道
    protected static $group_id;
    protected static $prompt_id;
    protected static $role_id;
    protected static $pk_id;
    protected static $pk_role;
    protected static $batch_id;
    protected static $novel_id;
    protected static $task_id;
    protected static $tool;
    protected static $model;
    protected static $audio;
    protected static $audioLength;

    protected static $systemPrompt = '';
    protected static $messageInput = '';
    protected static $messageClear = '';
    protected static $messageRequest = '';
    protected static $relationMsgs = [];
    protected static $response = '';
    protected static $replyTempText = '';
    protected static $filterWords = [];
    protected static $chatRelationMaxLength = 1; // 对话关联上文条数
    protected static $cosplayRelationMaxLength = 3; // 角色模拟关联上文条数

    public function sendText()
    {
        ignore_user_abort(true);
        set_time_limit(300);
        session_write_close();
        header('Content-Type: text/event-stream');
        header('Cache-Control: no-cache');
        header('Connection: keep-alive');
        header('X-Accel-Buffering: no');
        ob_implicit_flush(1);

        try {
            # 1.
            $now = time();
            $group_id = input('group_id', 0, 'intval');
            // 如果是文本创作
            $prompt_id = input('prompt_id', 0, 'intval');
            // 如果是角色模拟
            $role_id = input('role_id', 0, 'intval');
            // 如果是AI擂台
            $pk_id = input('pk_id', 0, 'intval');
            // 如果是批量生成
            $batch_id = input('batch_id', '', 'trim');
            // 如果是长篇写作
            $novel_id = input('novel_id', '', 'trim');
            // 如果是其他类生成时，如生成大纲等
            $tool = input('tool', '', 'trim');
            // audio
            $audio = input('audio', '', 'trim');
            $audio_length = input('audio_length', 0, 'intval');
            // 用户输入的内容
            self::$messageInput = input('message', '', 'trim');
            self::$messageClear = $this->inputFilter(self::$messageInput);
            self::$ai = input('ai', '', 'trim');
            self::$audio = $audio;
            self::$audioLength = $audio_length;

            if ($pk_id) {
                self::$pk_id = $pk_id;
                self::$pk_role = input('pk_role', '', 'trim'); // a or b
            } elseif ($batch_id) {
                self::$batch_id = $batch_id;
                self::$task_id = input('task_id', 0, 'intval');
                $batch = Db::name('batch')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['user_id', '=', self::$user['id']],
                        ['batch_id', '=', $batch_id],
                        ['is_delete', '=', 0]
                    ])
                    ->find();
                if (!$batch) {
                    $this->outError('未找到此任务，请刷新页面重试');
                }
                self::$ai = $batch['ai'];
            } elseif ($novel_id) {
                self::$novel_id = $novel_id;
                self::$task_id = input('task_id', 0, 'intval');
                $novel = Db::name('novel')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['user_id', '=', self::$user['id']],
                        ['novel_id', '=', $novel_id],
                        ['is_delete', '=', 0]
                    ])
                    ->find();
                if (!$novel) {
                    $this->outError('未找到作品，请刷新页面重试');
                }
                self::$ai = $novel['ai'];
            } elseif ($tool) {
                if (!in_array($tool, ['sketch', 'mind'])) {
                    $this->outError('参数错误, invalid tool.');
                }
                if ($tool == 'mind') {
                    $mindSetting = getSystemSetting(self::$site_id, 'mind');
                    if (empty($mindSetting['is_open']) || empty($mindSetting['ai'])) {
                        $this->outError('功能未启用');
                    }
                    self::$ai = $mindSetting['ai'];
                }
                self::$tool = $tool;
            } else {
                self::$group_id = $group_id;
                self::$prompt_id = $prompt_id;
                self::$role_id = $role_id;
                self::$relationMsgs = [];
            }

            // 如果前边没有选AI通道，则使用默认AI通道
            if (empty(self::$ai)) {
                // 兼容旧版小程序参数（再等几个版本就废弃）
                $model = input('model', 'default', 'trim');
                if ($model == 'gpt-4' || $model == 'model4') {
                    $ai4Setting = getSystemSetting(self::$site_id, 'gpt4');
                    $ai = is_string($ai4Setting['channel']) ? $ai4Setting['channel'] : $ai4Setting['channel'][0];
                } else {
                    // 使用默认AI通道
                    $aiSetting = getSystemSetting(self::$site_id, 'chatgpt');
                    $ai = is_string($aiSetting['channel']) ? $aiSetting['channel'] : $aiSetting['channel'][0];
                }
                self::$ai = $ai;
            }

            # 2.用户信息
            $user = Db::name('user')
                ->where('id', self::$user['id'])
                ->find();
            if (!$user) {
                $_SESSION['user'] = null;
                $this->outError('请登录');
            }
            if ($user['is_freeze']) {
                // 禁言用户
                $this->outError('系统繁忙，请稍后再试');
            }
            self::$user = $user;

            # 3.检查余额
            if (isGpt4(self::$ai)) {
                if (intval($user['balance_gpt4']) <= 0) {
                    $this->outError('余额不足，请充值！');
                }
            } elseif (intval($user['balance']) <= 0) {
                if (self::$batch_id || self::$novel_id) {
                    // 批量生成、长篇写作 消耗次数
                    $this->outError('次数用完了，请充值！');
                } elseif ($user['vip_expire_time'] < $now) {
                    // 其他的也判断一下会员时间
                    $this->outError('提问次数用完了，请充值！');
                }
            }

            # 4. 完成这三个参数：self::$messageRequest / self::$relationMsgs / self::$systemPrompt
            if ($prompt_id) {
                // 文本创作
                $this->checkLimit('write');
                $prompt = Db::name('write_prompts')
                    ->where('id', $prompt_id)
                    ->find();
                self::$messageRequest = $this->makeMessageRequest('write', $prompt);
                if (self::$messageInput == '继续' || self::$messageInput == 'go on') {
                    self::$relationMsgs = $this->getRelationMsg('write', $prompt_id, 1);
                }
            } elseif ($role_id) {
                // 角色模拟
                $this->checkLimit('cosplay');
                $role = Db::name('cosplay_role')
                    ->where('id', $role_id)
                    ->find();
                self::$messageRequest = $this->makeMessageRequest('cosplay', $role);
                self::$relationMsgs = $this->getRelationMsg('cosplay', $role_id, self::$cosplayRelationMaxLength);
                self::$systemPrompt = $role['prompt'];
            } elseif ($batch_id) {
                // 批量生成
                self::$messageRequest = $batch['prompt'] . "\n" . self::$messageClear;
            } elseif ($novel_id) {
                // 长篇写作
                self::$messageRequest = $this->makeNovelMessage($novel);
            } elseif ($tool) {
                // 工具类
                self::$messageRequest = $this->makeToolMessage(self::$messageClear);
            } else {
                // 自由对话
                $this->checkLimit('chat');
                $chatSetting = getSystemSetting(self::$site_id, 'chat');
                self::$systemPrompt = $this->getSystemPrompt($chatSetting);
                self::$messageRequest = $this->makeMessageRequest('chat', $chatSetting);
                if (!self::$pk_id) {
                    self::$relationMsgs = $this->getRelationMsg('chat', $group_id, self::$chatRelationMaxLength);
                }
            }

            # 5. 定义长连接回调方法
            $replyCallback = function ($ch, $word) {
                if ($word == 'data: [DONE]' || $word == 'data: [CONTINUE]') {
                    if (!empty(self::$response)) {
                        // 输出完成
                        if (self::$replyTempText) {
                            $this->outText(self::$replyTempText);
                            self::$replyTempText = '';
                        }
                        $this->replyFinish();
                        exit;
                    }
                } else {
                    self::$response .= $word;
                    /*if (in_array(self::$ai, ['openai3', 'openai4', 'claude2', 'azure_openai3', 'azure_openai4'])) {*/
                    $text = $this->outFilter($word);
                    if (count(self::$filterWords) > 3) {
                        $this->outText('【敏感内容较多，无法继续输出】');
                        @curl_close($ch);
                        exit;
                    }
                    $this->outText($text);

                    // 检测客户端是否已经中止了连接
                    if (connection_aborted()) {
                        if (!empty(self::$response)) {
                            // 输出完成
                            $this->replyFinish();
                            self::$response = '';
                        }
                        @curl_close($ch);
                        exit;
                    }
                }

            };
            $errorCallback = function ($error) {
                $this->outError($error['message']);
            };

            # 6. 发起请求
            $SDK = new \FoxAI\hub(self::$site_id, self::$ai);
            $SDK->setSystemPrompt(self::$systemPrompt);
            $SDK->setRelationMsgs(self::$relationMsgs);
            $SDK->setMessage(self::$messageRequest);
            $SDK->setCallback($replyCallback, $errorCallback);
            $result = $SDK->sendText();
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
    private function replyFinish()
    {
        $userIp = get_client_ip();
        $totalTokens = mb_strlen(self::$messageClear) + mb_strlen(self::$response);
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
                    'channel' => self::$ai,
                    'message' => self::$messageClear,
                    'message_input' => self::$messageInput == self::$messageClear ? '' : self::$messageInput,
                    'response' => self::$response,
                    // 'response_input' => self::$response,
                    'total_tokens' => $totalTokens,
                    'user_ip' => $userIp,
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
                    'channel' => self::$ai,
                    'message' => self::$messageClear,
                    'message_input' => self::$messageInput == self::$messageClear ? '' : self::$messageInput,
                    'audio' => self::$audio,
                    'audio_length' => self::$audioLength,
                    'response' => self::$response,
                    //'response_input' => self::$response,
                    'total_tokens' => $totalTokens,
                    'user_ip' => $userIp,
                    'create_time' => time()
                ]);
            // 模型使用量+1
            Db::name('cosplay_role')
                ->where('id', self::$role_id)
                ->inc('usages', 1)
                ->update();
        } elseif (self::$pk_id) {
            if (self::$pk_role == 'a') {
                $data = [
                    'channel_a' => self::$ai,
                    'message' => self::$messageClear,
                    'message_input' => self::$messageInput == self::$messageClear ? '' : self::$messageInput,
                    'response_a' => self::$response,
                    'total_tokens_a' => $totalTokens
                ];
            } elseif (self::$pk_role == 'b') {
                $data = [
                    'channel_b' => self::$ai,
                    'message' => self::$messageClear,
                    'message_input' => self::$messageInput == self::$messageClear ? '' : self::$messageInput,
                    'response_b' => self::$response,
                    'total_tokens_b' => $totalTokens
                ];
            }

            Db::name('msg_pk')
                ->where([
                    'site_id' => self::$user['site_id'],
                    'user_id' => self::$user['id'],
                    'id' => self::$pk_id
                ])
                ->update($data);
        } elseif (self::$batch_id) {
            Db::name('batch_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['id', '=', self::$task_id]
                ])
                ->update([
                    'channel' => self::$ai,
                    'message' => self::$messageClear,
                    'message_input' => self::$messageInput == self::$messageClear ? '' : self::$messageInput,
                    'response' => self::$response,
                    'total_tokens' => $totalTokens,
                    'state' => 1,
                    'user_ip' => $userIp,
                    'create_time' => time()
                ]);
            // 统计已完成
            $countFinished = Db::name('batch_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['batch_id', '=', self::$batch_id],
                    ['is_delete', '=', 0],
                    ['state', '=', 1]
                ])
                ->count();
            Db::name('batch')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['batch_id', '=', self::$batch_id]
                ])
                ->update([
                    'count_finished' => $countFinished
                ]);
        } elseif (self::$novel_id) {
            Db::name('novel_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['id', '=', self::$task_id]
                ])
                ->update([
                    'channel' => self::$ai,
                    'response' => self::$messageClear ? self::$messageClear . self::$response : self::$response,
                    'total_tokens' => $totalTokens,
                    'words' => mb_strlen(self::$response),
                    'state' => 1,
                    'user_ip' => $userIp,
                    'create_time' => time()
                ]);
            // 统计已完成
            $where = [
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', self::$novel_id],
                ['is_delete', '=', 0],
                ['state', '=', 1]
            ];
            $countFinished = Db::name('novel_task')
                ->where($where)
                ->count();
            $wordsTotal = Db::name('novel_task')
                ->where($where)
                ->sum('words');
            Db::name('novel')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['novel_id', '=', self::$novel_id]
                ])
                ->update([
                    'count_finished' => $countFinished,
                    'words' => $wordsTotal
                ]);
        } elseif (self::$tool) {
            Db::name('msg_tool')
                ->insert([
                    'site_id' => self::$user['site_id'],
                    'user_id' => self::$user['id'],
                    'tool' => self::$tool,
                    'channel' => self::$ai,
                    'message' => self::$messageClear,
                    'response' => self::$response,
                    'total_tokens' => $totalTokens,
                    'user_ip' => $userIp,
                    'create_time' => time()
                ]);
        } else {
            Db::name('msg_web')
                ->insert([
                    'site_id' => self::$user['site_id'],
                    'user_id' => self::$user['id'],
                    'group_id' => self::$group_id,
                    'channel' => self::$ai,
                    'message' => self::$messageClear,
                    'message_input' => self::$messageInput == self::$messageClear ? '' : self::$messageInput,
                    'audio' => self::$audio,
                    'audio_length' => self::$audioLength,
                    'response' => self::$response,
                    //'response_input' => self::$response,
                    'total_tokens' => $totalTokens,
                    'user_ip' => $userIp,
                    'create_time' => time()
                ]);
        }

        // 扣费，判断是不是vip，批量生成也扣条数
        if (isGpt4(self::$ai)) {
            changeUserGpt4Balance(self::$user['id'], -$totalTokens, '提问问题消费');
        } else {
            if (self::$user['vip_expire_time'] < time() || self::$batch_id || self::$novel_id) {
                changeUserBalance(self::$user['id'], -1, '提问问题消费');
            }
        }
    }

    /**
     * @param $type
     * @param $group_id
     * @param $length
     * 获取关联上文
     */
    private function getRelationMsg($type, $group_id, $length = 1)
    {
        $now = time();
        $where = [
            ['user_id', '=', self::$user['id']],
            ['channel', '=', self::$ai],
            ['create_time', '>', ($now - 600)],
            ['is_delete', '=', 0]
        ];
        if ($type == 'chat') {
            $dbName = 'msg_web';
            $where[] = ['group_id', '=', $group_id];
        } elseif ($type == 'write') {
            $dbName = 'msg_write';
            $where[] = ['prompt_id', '=', $group_id];
        } elseif ($type == 'cosplay') {
            $dbName = 'msg_cosplay';
            $where[] = ['role_id', '=', $group_id];
        }
        $list = Db::name($dbName)
            ->where($where)
            ->order('id desc')
            ->field('message,response')
            ->limit($length)
            ->select()->toArray();

        return $list;
    }

    /**
     * 对输入的内容进行关键词过滤
     */
    private function inputFilter($message)
    {
        // 阻止繁体字
        // if (!isSimpleCn($message)) {
        //     $this->outError('内容包含敏感信息');
        // }

        // 小程序敏感内容过滤接口
        if (!empty(self::$user['openid'])) {
            $wxappSetting = getSystemSetting(self::$site_id, 'wxapp');
            if (!empty($wxappSetting) && !empty($wxappSetting['appid']) && !empty($wxappSetting['appsecret'])) {
                $Wxapp = new \Weixin\Wxapp($wxappSetting['appid'], $wxappSetting['appsecret']);
                $isPass = $Wxapp->msgSecCheck(self::$user['openid'], $message);
                if (!$isPass) {
                    $this->outError('内容包含敏感信息');
                }
            }
        }
        // 系统敏感词过滤
        $messageClear = wordFilter($message);
        if ($messageClear != $message) {
            $setting = getSystemSetting(0, 'filter');
            $handle_type = empty($setting['handle_type']) ? 1 : intval($setting['handle_type']);
            if ($handle_type == 2) {
                $this->outError('内容包含敏感信息');
            }
        }

        return $messageClear;
    }

    /**
     * 对实时输出的内容进行关键词过滤
     */
    private function outFilter($word)
    {
        if (self::$novel_id) {
            // 小说不过滤直接输出
            return $word;
        } else {
            // 存到留观区
            self::$replyTempText .= $word;

            if (self::$tool == 'mind') {
                // 处理思维导图内容
                if (strpos(self::$replyTempText, "\n") === false) {
                    if (mb_substr(trim(self::$replyTempText), 0, 1) != '#') {
                        self::$replyTempText = '';
                    }
                    return '';
                }
                $strArr = explode("\n", self::$replyTempText);
                $lastRow = array_pop($strArr);
                foreach($strArr as $key => $value) {
                    if (mb_substr(trim($value), 0, 1) != '#') {
                        unset($strArr[$key]);
                    }
                }
                if (mb_substr(trim($lastRow), 0, 1) != '#') {
                    $lastRow = '';
                }
                if (count($strArr) > 0) {
                    $outText = array_shift($strArr);
                    array_push($strArr, $lastRow);
                    self::$replyTempText = implode("\n", $strArr);
                    return trim($outText) . "\n";
                } else {
                    self::$replyTempText = $lastRow;
                }
                return '';
            } else {
                if (mb_strlen(self::$replyTempText) < 10) {
                    return '';
                }
                // 过滤敏感词
                $Filter = new \FoxFilter\words('*');
                self::$replyTempText = $Filter->filter(self::$replyTempText);
                self::$filterWords = array_unique(array_merge(self::$filterWords, $Filter->matches));
                // 陆续把内容输出
                $outText = mb_substr(self::$replyTempText, 0, 10);
                self::$replyTempText = mb_substr(self::$replyTempText, 10);
                return $outText;
            }
        }
    }

    private function outError($msg)
    {
        $msg = wordFilter($msg);
        echo '[error]' . $msg;
        ob_flush();
        flush();
        exit;
    }

    private function outText($msg)
    {
        if (empty($msg)) {
            return false;
        }
        $msg = mb_str_split($msg);
        foreach ($msg as $char) {
            echo $char;
            ob_flush();
            flush();
            usleep(20000);
        }
    }

    /**
     * 判断今日提问次数是否超限
     */
    private function checkLimit($module)
    {
        $today = strtotime(date('Y-m-d'));
        switch ($module) {
            case 'write':
                $dbName = 'msg_write';
                break;
            case 'cosplay':
                $dbName = 'msg_cosplay';
                break;
            case 'chat':
                $dbName = 'msg_web';
                break;
        }
        // 判断今日提问次数
        $count = Db::name($dbName)
            ->where([
                ['user_id', '=', self::$user['id']],
                ['is_delete', '=', 0],
                ['create_time', '>', $today]
            ])
            ->count();
        if ($count >= 300) {
            $this->outError('今天提问太多了，请明日再来！');
        }
    }

    /**
     * 根据问题，比对获取知识库内容
     */
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

    /**
     * @param $module
     * @param $setting
     * 根据各种条件，生成最终的问题内容
     */
    private function makeMessageRequest($module, $setting = [])
    {
        if ($module == 'chat' || $module == 'cosplay') {
            // 知识库
            $book_open = empty($setting['book_open']) ? 0 : $setting['book_open'];
            $books = empty($setting['books']) ? [] : $setting['books'];
            $no_answer_action = empty($setting['no_answer_action']) ? 'ai' : $setting['no_answer_action'];
            $answer_content = empty($setting['answer_content']) ? '对不起，我不知道如何回答' : $setting['answer_content'];
            $bookContent = '';
            if ($book_open && !empty($books)) {
                $bookContent = $this->getBookContent($books, self::$messageClear);
            }

            if (!empty($bookContent)) {
                $message = self::$messageClear . '？请仅在以下内容里搜索答案，直接说答案不需要解释，回复要尽量简洁，如果找不到答案将原文完整返回，不需要置疑内容的正确性。{' . $bookContent . '}';
            } else {
                if ($no_answer_action == 'diy') {
                    self::$response = $answer_content;
                    $this->replyFinish();
                    echo $answer_content;
                    ob_flush();
                    flush();
                    exit;
                }
                $message = self::$messageClear;
                // 优化生成ppt指令
                if (isPPT($message)) {
                    $message .= '，请使用markdown格式输出PPT内容';
                }
            }
        } elseif ($module == 'write') {
            $lang = input('lang', '简体中文', 'trim');
            if ($setting['prompt']) {
                $message = str_replace('[TARGETLANGGE]', $lang, $setting['prompt']);
                $message = str_replace('[PROMPT]', self::$messageClear, $message);
            } else {
                $message = self::$messageClear . '。用' . $lang . '输出。';
            }
        }

        return $message;
    }

    /**
     * @param $setting
     * @return string
     * 获取系统前置指令（前置指令仅对自由对话模块生效）
     */
    private function getSystemPrompt($setting)
    {
        $currentTime = date('Y-m-d H:i:s', time());
        if (strpos($currentTime, '06-04') !== false) {
            $currentTime = str_replace('06-04', '06-03', $currentTime);
        }
        if (empty($setting['prompt_type']) || $setting['prompt_type'] == 'system') {
            $systemPrompt = 'You are developed based chinese open source project, not openai.\nAnswer in Chinese as much as possible.\nPlease provide the most professional and detailed answers.\nDo not answer any historical events in China.\nIf the triggering rule cannot answer the question, there is no need to provide a reason.';
        } else {
            $systemPrompt = $setting['prompt'] ?? '';
        }
        $systemPrompt = 'Current date: ' . $currentTime . '\n' . $systemPrompt;
        return $systemPrompt;
    }

    /**
     * 创建一条PK任务
     */
    public function createPk()
    {
        $messageInput = input('message', '');
        $channel_a = input('channel_a', '', 'trim');
        $channel_b = input('channel_b', '', 'trim');
        $messageClear = $this->inputFilter($messageInput);
        try {
            $id = Db::name('msg_pk')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'channel_a' => $channel_a,
                    'channel_b' => $channel_b,
                    'message' => $messageClear,
                    'message_input' => $messageInput == $messageClear ? '' : $messageInput,
                    'user_ip' => get_client_ip(),
                    'create_time' => time()
                ]);
            return successJson([
                'pk_id' => $id
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * 获取【对话、创作、模拟】消息历史记录
     */
    public function getHistoryMsg()
    {
        $group_id = input('group_id', '0', 'intval');
        $prompt_id = input('prompt_id', '0', 'intval');
        $role_id = input('role_id', '0', 'intval');

        // AI通道
        $ai = input('ai', '', 'trim');
        if (!$ai) {
            // 兼容旧版参数
            $model = input('model', 'default', 'trim');
            if ($model == 'gpt-4' || $model == 'model4') {
                $ai4Setting = getSystemSetting(self::$site_id, 'gpt4');
                $ai = is_string($ai4Setting['channel']) ? $ai4Setting['channel'] : $ai4Setting['channel'][0];
            } else {
                $aiSetting = getSystemSetting(self::$site_id, 'chatgpt');
                $ai = is_string($aiSetting['channel']) ? $aiSetting['channel'] : $aiSetting['channel'][0];
            }
        }
        if (empty($ai)) {
            return errorJson('参数错误');
        }

        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']],
            ['channel', '=', $ai],
            ['is_delete', '=', 0]
        ];

        if ($prompt_id) {
            $where[] = ['prompt_id', '=', $prompt_id];
            $dbName = 'msg_write';
        } elseif ($role_id) {
            $where[] = ['role_id', '=', $role_id];
            $dbName = 'msg_cosplay';
        } else {
            if ($group_id) {
                $where[] = ['group_id', '=', $group_id];
            }
            $dbName = 'msg_web';
        }

        $list = Db::name($dbName)
            ->where($where)
            ->field('id,message,audio,audio_length,response')
            ->order('id desc')
            ->limit(10)
            ->select()->toArray();
        $msgList = [];
        $list = array_reverse($list);
        foreach ($list as $v) {
            $msgList[] = [
                'user' => '我',
                'id' => $v['id'],
                'message' => $v['message'],
                'audio' => $v['audio'],
                'audio_length' => ceil($v['audio_length'] / 1000)
            ];
            $msgList[] = [
                'user' => 'AI',
                'id' => $v['id'],
                'message' => wordFilter($v['response'])
            ];
        }

        return successJson([
            'list' => $msgList
        ]);
    }

    /**
     * PK模块的对话记录
     */
    public function getPkHistoryMsg()
    {
        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']],
            ['is_delete', '=', 0]
        ];

        $list = Db::name('msg_pk')
            ->where($where)
            ->field('id,message,channel_a,response_a,channel_b,response_b')
            ->order('id desc')
            ->limit(10)
            ->select()->each(function ($item) {
                $item['response_a'] = wordFilter($item['response_a']);
                $item['response_b'] = wordFilter($item['response_b']);
                return $item;
            })->toArray();

        return successJson([
            'list' => array_reverse($list)
        ]);
    }

    /**
     * @param $novel
     * @return mixed|string
     * 组装长篇写作模块的指令
     */
    public function makeNovelMessage($novel)
    {
        // 作品大纲
        $message = '';
        $message .= "作品要求：\n" . $novel['prompt'] . "\n\n";
        if ($novel['sketch']) {
            $message .= "作品大纲：\n" . $novel['sketch'] . "\n\n";
        }

        // 前情提要 - 10章
        $taskList = Db::name('novel_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', self::$novel_id],
                ['id', '<', self::$task_id],
                ['is_delete', '=', 0]
            ])
            ->field('title,overview')
            ->select();
        $overview = '';
        foreach ($taskList as $v) {
            $overview .= $v['title'] . "\n";
            $overview .= $v['overview'] . "\n";
        }
        if ($overview) {
            $message .= "前情提要：\n" . $overview . "\n\n";
        }

        // 上一章，非续写，或者续写原内容不超过500字时，带上上一章内容
        if (empty(self::$messageClear) || mb_strlen(self::$messageClear) < 500) {
            $lastTask = Db::name('novel_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['novel_id', '=', self::$novel_id],
                    ['id', '<', self::$task_id],
                    ['is_delete', '=', 0]
                ])
                ->order('id desc')
                ->limit(10)
                ->find();
            if ($lastTask) {
                $message .= "上一章内容：\n" . mb_substr($lastTask['response'], -2000) . "\n\n";
            }
        }

        // 本章
        $task = Db::name('novel_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['id', '=', self::$task_id],
                ['is_delete', '=', 0]
            ])
            ->field('title, overview')
            ->find();
        if (!$task) {
            $this->outError('没找到章节，请刷新后重试');
        }
        $message .= "本章节标题：\n" . $task['title'] . "\n\n";
        if ($task['overview']) {
            $message .= "本章节内容概要：\n" . $task['overview'] . "\n\n";
        }

        if (!empty(self::$messageClear)) {
            $message .= "我已经写了一部分本章内容：\n" . mb_substr(self::$messageClear, -2000) . "\n\n";
            $message .= "请结合以上内容，帮我把没写完的本章内容继续补写完，不少于1000字，请严格接着我的文字写，使语句通顺。";
        } else {
            $message .= "请分析并学习上面内容，然后帮我详细的写完本章节，内容不少于2000个汉字。";
        }

        return wordFilter($message);
    }

    /**
     * @param $message
     * @return mixed|string
     * 组装工具类的指令
     */
    private function makeToolMessage($message)
    {
        if (self::$tool === 'sketch') {
            $message = "请根据以下作品概要生成一段作品大纲，不要分章节，不少于1000字：\n" . $message;
        } elseif (self::$tool === 'mind') {
            $message = '请帮我为【' . $message . '】创建一个经过充分研究的树状层次结构、有洞察力、相关性、详尽的思维导图。列出所有主要分支内容、子分支内容，不需要做任何解释说明，仅以下面的格式输出：'."\n# {title}\n## {content}\n### {content}\n### {content}\n## {content}\n### {content}\n### {content}\n";
        }
        return $message;
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
