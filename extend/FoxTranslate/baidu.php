<?php

namespace FoxTranslate;
class baidu
{
    protected static $apikey = '';
    protected static $secretkey = '';
    protected static $from = 'cn';
    protected static $to = 'en';
    /**
     * sdk constructor.
     * @param string $apikey
     * @param string $secretkey
     */
    public function __construct($apikey, $secretkey, $from = 'cn', $to = 'en')
    {
        self::$apikey = $apikey;
        self::$secretkey = $secretkey;
        if (!empty($from)) {
            self::$from = $from;
        }
        if (!empty($to)) {
            self::$to = $to;
        }
    }

    public function getAccessToken()
    {
        // 读取存储的 access_token
        $now = time();
        $accessTokenFile = __DIR__ . '/baidu_access_token_' . self::$apikey . '.php';
        if (file_exists($accessTokenFile)) {
            $content = trim(substr(file_get_contents($accessTokenFile), 15));
            $data = json_decode($content);
        }

        $access_token = '';
        if (empty($data) || $data->expire_time < $now) {
            // 获取新token
            $url = 'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=' . self::$apikey . '&client_secret=' . self::$secretkey;
            $res = json_decode(file_get_contents($url));
            if (!empty($res->access_token)) {
                $access_token = $res->access_token;
                $data = [
                    'access_token' => $access_token,
                    'expire_time' => $now + $res->expires_in
                ];
                file_put_contents($accessTokenFile, '<?php exit();?>' . json_encode($data));
            }
        } else {
            $access_token = $data->access_token;
        }

        return $access_token;
    }

    /**
     * @param $text
     * @return mixed
     * 中文翻译成英文
     */
    public function cn2En($text)
    {
        $url = 'https://aip.baidubce.com/rpc/2.0/mt/texttrans/v1?access_token=' .  $this->getAccessToken();
        $post = [
            'from' => 'zh',
            'to' => 'en',
            'q' => $text
        ];
        $result = $this->httpRequest($url, $post);
        if (isset($result['error_code']) || !isset($result['result']['trans_result'])) {
            return $text;
        }

        $str = '';
        foreach ($result['result']['trans_result'] as $v) {
            if (!empty($v['dst'])) {
                $str .= $v['dst'];
                $str .= ',';
            }
        }
        $text = rtrim($str, ',');

        return $text;
    }

    /**
     * http请求
     */
    protected function httpRequest($url, $post = null)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json;charset=utf-8'
        ]);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post));
        }
        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            return [
                'error_code' => 1,
                'error_msg' => 'curl错误: ' . curl_error($ch)
            ];
        }
        curl_close($ch);
        return json_decode($result, true);
    }

}
