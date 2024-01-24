<?php

namespace ChatGPT;
use think\facade\Request;

class minimax
{
    protected static $model = 'abab5.5-chat';
    protected static $apiKey = '';
    protected static $groupId = '';
    protected static $apiUrl = 'https://api.minimax.chat/v1/text/chatcompletion_pro';
    protected static $temperature = 0.9;
    protected static $max_tokens = 5000;

    /**
     * sdk constructor.
     * @param string $apiKey
     * @param string $groupId
     * @param string $temperature
     * @param string $max_tokens
     */
    public function __construct($groupId = '', $apiKey = '', $temperature = '', $max_tokens = '')
    {
        if ($temperature) {
            self::$temperature = $temperature;
        }
        if ($max_tokens) {
            self::$max_tokens = $max_tokens;
        }
        self::$apiKey = $apiKey;
        self::$groupId = $groupId;
    }

    /**
     * @param $message
     * @param $system
     * @param $callback
     * @return array|mixed
     */
    public function sendText($questions = [], $system = '', $callback = null)
    {
        $messages = [];
        foreach ($questions as $v) {
            if ($v['role'] == 'user') {
                $messages[] = [
                    'sender_type' => 'USER',
                    'sender_name' => '我',
                    'text' => $v['content']
                ];
            } elseif ($v['role'] == 'assistant') {
                $messages[] = [
                    'sender_type' => 'BOT',
                    'sender_name' => 'AI',
                    'text' => $v['content']
                ];
            }
        }
        $url = self::$apiUrl . '?' . 'GroupId=' . self::$groupId;
        $post = [
            'model' => self::$model,
            'stream' => true,
            'tokens_to_generate' => intval(self::$max_tokens),
            'temperature' => floatval(self::$temperature),
            'messages' => $messages,
            'bot_setting' => [
                [
                    'bot_name' => 'AI',
                    'content' => $system ?: 'Article Assistant'
                ]
            ],
            'reply_constraints' => [
                "sender_type" => 'BOT',
                "sender_name" => 'AI'
            ]
        ];

        $result = $this->httpRequest($url, $post, $callback);
        return $this->handleError($result);
    }

    public function getEmbedding($text)
    {
        $controller = Request::controller();
        if (strtolower($controller) != 'admin') {
            $type = 'query';
        } else {
            $type = 'db';
        }
        $url = 'https://api.minimax.chat/v1/embeddings' . '?' . 'GroupId=' . self::$groupId;
        $post = [
            'model' => 'embo-01',
            'texts' => [$text],
            'type' => $type
        ];

        $result = $this->httpRequest($url, $post);
        if (!empty($result['vectors'])) {
            return json_encode($result['vectors'][0]);
        } else {
            return '';
        }
    }

    /**
     * @param $result
     * @return array|mixed
     * 格式化接口报错
     */
    protected function handleError($result)
    {
        if (isset($result['errno'])) {
            return [
                'errno' => 1,
                'message' => $result['message']
            ];
        }
        if (isset($result['error'])) {
            return [
                'errno' => 1,
                'message' => $result['error']['message']
            ];
        }

        return $result;
    }

    /**
     * http请求
     */
    protected function httpRequest($url, $post = null, $callback = null)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: Bearer ' . self::$apiKey
        ]);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post));
        }
        if ($callback) {
            curl_setopt($ch, CURLOPT_WRITEFUNCTION, $callback);
        }
        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            return [
                'errno' => 1,
                'message' => 'curl 错误信息: ' . curl_error($ch)
            ];
        }
        curl_close($ch);
        return json_decode($result, true);
    }
}