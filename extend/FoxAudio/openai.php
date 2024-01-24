<?php

namespace FoxAudio;

class openai
{
    protected static $apiKey = '';
    protected static $options = [
        'model' => 'tts-1-hd',
        'voice' => 'alloy'
    ];
    protected static $apiHost = 'https://api.openai.com';

    /**
     * @param string $apiKey
     * @param array $options
     */
    public function __construct($apiKey, $options)
    {
        self::$apiKey = $apiKey;
        self::$options = $options;
    }

    public function setApiHost($host)
    {
        self::$apiHost = $host;
    }

    /**
     * @param $text
     * @param $voice
     * @return array|mixed
     * 文字转语音
     */
    public function text2Audio($text)
    {
        $url = self::$apiHost . '/v1/audio/speech';
        $header = [
            'Content-Type: application/json',
            'Authorization: Bearer ' . self::$apiKey
        ];
        $post = [
            'model' => self::$options['model'] ?? 'tts-1-hd',
            'input' => $text,
            'voice' => self::$options['voice'] ?? 'alloy',
            'response_format' => 'mp3',
            'speed' => 1
        ];
        $result = $this->httpRequest($url, $header, json_encode($post));

        return $this->handleError($result);
    }

    public function audio2Text($file)
    {
        $url = self::$apiHost . '/v1/audio/transcriptions';
        $header = [
            'Content-Type: multipart/form-data',
            'Authorization: Bearer ' . self::$apiKey
        ];
        $post = [
            'file' => curl_file_create(realpath($file)),
            'model' => 'whisper-1',
            'language' => 'zh',
            'response_format' => 'text'
        ];
        $result = $this->httpRequest($url, $header, $post);

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
        elseif (isset($result['error'])) {
            return [
                'errno' => 1,
                'message' => wordFilter($result['error']['message'])
            ];
        }
        // api2d的错误
        elseif (isset($result['object']) && $result['object'] == 'error') {
            return [
                'errno' => 1,
                'message' => wordFilter($result['message'])
            ];
        }

        return $result;
    }

    /**
     * http请求
     */
    protected function httpRequest($url, $header, $post = null)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        }
        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            return [
                'errno' => 1,
                'message' => 'curl 错误信息: ' . curl_error($ch)
            ];
        }
        curl_close($ch);
        return $result;
    }

    private function httpUpload($url, $header, $data = '')
    {

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); //处理http证书问题
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 50);
        curl_setopt($ch, CURLOPT_DNS_USE_GLOBAL_CACHE, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: Bearer ' . self::$apiKey
        ]);
        $ret = curl_exec($ch);
        if (false === $ret) {
            return curl_errno($ch);
        }
        curl_close($ch);

        return @json_decode($ret, true);
    }
}
