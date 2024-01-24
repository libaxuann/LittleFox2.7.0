<?php

namespace ChatGPT;

class azure
{
    protected static $model = 'gpt-35-turbo';
    protected static $apiKey = '';
    protected static $apiHost = '';
    protected static $temperature = 0.9;
    protected static $max_tokens = 3000;
    protected static $apiVersion = '2023-05-15';

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

    public function setApiHost($host)
    {
        self::$apiHost = $host;
    }

    /**
     * @param string $message
     * @return array
     * GPT3.5以上模型
     * 流式输出
     */
    public function sendText($message = [], $callback = null)
    {
        $url = self::$apiHost . 'openai/deployments/' . self::$model . '/chat/completions?api-version=' . self::$apiVersion;
        $post = [
            'messages' => $message,
            'max_tokens' => intval(self::$max_tokens),
            'temperature' => floatval(self::$temperature),
            'frequency_penalty' => 0,
            'presence_penalty' => 0.6,
            'stream' => true
        ];
        $result = $this->httpRequest($url, $post, $callback);

        return $this->handleError($result);
    }

    public function getEmbedding($text)
    {
        $url = self::$apiHost . 'openai/deployments/text-embedding-ada-002/embeddings?api-version=' . self::$apiVersion;
        $post = [
            'input' => $text
        ];
        $result = $this->httpRequest($url, $post);
        if (!empty($result['data'][0]['embedding'])) {
            return json_encode($result['data'][0]['embedding']);
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
            'api-key: ' . self::$apiKey
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
