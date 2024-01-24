<?php

namespace ChatGPT;

class hunyuan
{
    protected static $appid = '';
    protected static $secretId = '';
    protected static $secretKey = '';
    protected static $temperature = 0.5;
    protected static $apiUrl = 'https://hunyuan.cloud.tencent.com/hyllm/v1/chat/completions';

    /**
     * @param $appid
     * @param $secretId
     * @param $secretKey
     * @param $temperature
     */
    public function __construct($appid = '',$secretId = '',$secretKey = '', $temperature = 0.5)
    {
        self::$appid = $appid;
        self::$secretId = $secretId;
        self::$secretKey = $secretKey;
        self::$temperature = $temperature;
    }

    /**
     * @param $message
     * @param $callback
     * @return array|mixed
     */
    public function sendText($message = [], $callback = null)
    {
        $now = time();
        $post = [
            'app_id' => intval(self::$appid),
            'secret_id' => self::$secretId,
            // 'query_id' => $this->createNonceStr(16),
            'messages' => $message,
            'temperature' => floatval(self::$temperature),
            'stream' => 1,
            'timestamp' => $now,
            'expired' => $now + 24 * 60 * 60
        ];
        $result = $this->httpRequest(self::$apiUrl, $post, $callback);
        return $this->handleError($result);
    }

    /**
     * @param $length
     * @return string
     * 生成随机字符串
     */
    protected function createNonceStr($length = 32)
    {
        $chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
        $str = '';
        for ($i = 0; $i < $length; $i++ )  {
            $str .= substr($chars, mt_rand(0, strlen($chars)-1), 1);
        }
        return $str;
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

    protected function createSign($reqArr)
    {
        $signStr = str_replace('https://', '', self::$apiUrl);
        $signStr .= "?";
        ksort($reqArr, SORT_STRING);
        foreach ($reqArr as $key => $val) {
            if ($key == 'messages') {
                $val = $this->convertMessage($val);
            }
            $signStr .= $key . '=' . $val . '&';
        }
        $signStr = substr($signStr, 0, -1);

        $signStr = base64_encode(hash_hmac('SHA1', $signStr, self::$secretKey, true));

        return $signStr;
    }
    private function convertMessage($msgs)
    {
        $str = implode(',', array_map(function ($message) {
            return '{"role":"' . $message['role'] . '","content":"' . $message["content"] . '"}';
        }, $msgs));
        $str = '[' . $str . ']';
        return $str;
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

        if ($post) {
            $signature = $this->createSign($post);
            $header = [
                'Content-Type: application/json',
                'Authorization: ' . $signature
            ];
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
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