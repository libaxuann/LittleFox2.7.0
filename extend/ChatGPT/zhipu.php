<?php

namespace ChatGPT;
use Firebase\JWT\JWT;

class zhipu
{
    protected static $model = 'chatglm_turbo';
    protected static $apiKey = '';
    protected static $temperature = 0.95;
    protected static $max_tokens = 3000;
    protected static $apis = [
        'chatglm_pro' => 'https://open.bigmodel.cn/api/paas/v3/model-api/chatglm_pro/sse-invoke',
        'chatglm_std' => 'https://open.bigmodel.cn/api/paas/v3/model-api/chatglm_std/sse-invoke',
        'chatglm_lite' => 'https://open.bigmodel.cn/api/paas/v3/model-api/chatglm_lite/sse-invoke',
        'chatglm_lite_32k' => 'https://open.bigmodel.cn/api/paas/v3/model-api/chatglm_lite_32k/sse-invoke',
        'characterglm' => 'https://open.bigmodel.cn/api/paas/v3/model-api/characterglm/sse-invoke',
        'chatglm_turbo' => 'https://open.bigmodel.cn/api/paas/v3/model-api/chatglm_turbo/sse-invoke'
    ];

    /**
     * @param string $apiKey
     * @param string $model
     * @param string $temperature
     */
    public function __construct($apiKey = '', $model = '', $temperature = '', $max_tokens = 3000)
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
     * @param $message
     * @param $callback
     * @return array|mixed
     */
    public function sendText($message = [], $callback = null)
    {
        $url = self::$apis[self::$model];
        $post = [
            'prompt' => $message,
            'temperature' => floatval(self::$temperature),
            'max_tokens' => self::$max_tokens,
            'incremental' => true,
            'return_type' => 'json_string'
        ];
        $result = $this->httpRequest($url, $post, true, $callback);

        return $this->handleError($result);
    }

    /**
     * @param $text
     * @return false|string
     */
    public function getEmbedding($text)
    {
        if (mb_strlen($text) > 512) {
            return '';
        }
        $url = 'https://open.bigmodel.cn/api/paas/v3/model-api/text_embedding/invoke';
        $post = [
            'prompt' => $text
        ];

        $result = $this->httpRequest($url, $post, false);
        if (isset($result['code']) && $result['code'] == 200 && !empty($result['data']['embedding'])) {
            return json_encode($result['data']['embedding']);
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
        if ($result['code']) {
            return [
                'errno' => 1,
                'message' => $result['msg']
            ];
        }

        return $result;
    }

    protected function makeToken()
    {
        list($id, $secret) = explode('.', self::$apiKey);
        $now = time();
        $timestamp = $now * 1000;
        $payload = [
            'api_key' => $id,
            'exp' => $timestamp + 72 * 3600 * 1000,
            'timestamp' => $timestamp
        ];
        $header = [
            'alg' => 'HS256',
            'sign_type' => 'SIGN'
        ];
        return JWT::encode($payload, $secret, 'HS256', $id, $header);
    }

    /**
     * http请求
     */
    protected function httpRequest($url, $post = null, $stream = true, $callback = null)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        $token = $this->makeToken();
        $header = [
            'Content-Type: application/json',
            'Authorization:' . $token
        ];
        if ($stream) {
            $header[] = 'accept: text/event-stream';
        }
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
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