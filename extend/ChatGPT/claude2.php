<?php

namespace ChatGPT;

class claude2
{
    protected static $model = 'claude-2';
    protected static $apiKey = '';
//    protected static $apiHost = 'https://api.anthropic.com';
    protected static $apiHost = 'https://xqtd520qidong.com';
    protected static $temperature = 0.9;
    protected static $max_tokens = 5000;

    /**
     * sdk constructor.
     * @param string $apiKey
     * @param string $model
     * @param string $temperature
     * @param string $max_tokens
     */
    public function __construct($apiKey = '', $model = '', $temperature = '', $max_tokens = '')
    {
        if ($model) {
            self::$model = $model;
        }
        if ($temperature) {
            self::$temperature = $temperature;
        }
        if ($max_tokens) {
            self::$max_tokens = $max_tokens;
        }
        self::$apiKey = $apiKey;
    }


    /**
     * @param string $message
     * @return array
     * GPT3.5以上模型
     * 流式输出
     */
    public function sendText($message = [], $callback = null)
    {
        $url = self::$apiHost . '/v1/chat/completions';
        $post = [
            'messages' => $message,
            'max_tokens_to_sample' => intval(self::$max_tokens),
            'temperature' => floatval(self::$temperature),
            'model' => self::$model,
            'stream' => true
        ];
        $result = $this->httpRequest($url, $post, $callback);

        return $this->handleError($result);
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
        // api2d的错误
        if (isset($result['object']) && $result['object'] == 'error') {
            return [
                'errno' => 1,
                'message' => $result['message']
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
//            'accept: application/json',
//            'anthropic-version: 2023-06-01',
//            'content-Type: application/json',
//            'x-api-key:' . self::$apiKey
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