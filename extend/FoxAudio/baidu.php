<?php

namespace FoxAudio;
class baidu
{
    protected static $apikey = '';
    protected static $secretkey = '';
    protected static $options = [
        'spd' => 5,
        'pit' => 5,
        'per' => 5118
    ];
    /**
     * sdk constructor.
     * @param string $apikey
     * @param string $secretkey
     */
    public function __construct($apikey, $secretkey, $options)
    {
        self::$apikey = trim($apikey);
        self::$secretkey = trim($secretkey);
        self::$options = $options;
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
     */
    public function text2Audio($text)
    {
        $url = 'https://tsn.baidu.com/text2audio';
        $header = [
            'Content-Type: application/x-www-form-urlencoded'
        ];
        $post = [
            'tex' => urlencode($text),
            'tok' => $this->getAccessToken(),
            'cuid' => self::$options['cuid'] . '',
            'ctp' => '1',
            'lan' => 'zh',
            'spd' => intval(self::$options['spd']),
            'pit' => intval(self::$options['pit']),
            'per' => intval(self::$options['per']),
            'aue' => 3 . ''
        ];
        $result = $this->httpRequest($url, $header, http_build_query($post));

        if (strpos($result, 'err_msg') !== false) {
            $result = json_decode($result, true);
            return [
                'errno' => 1,
                'message' => $result['err_msg'] ?? '出现错误'
            ];
        }

        return $result;
    }

    public function audio2Text($audioFile)
    {
        $url = 'http://vop.baidu.com/server_api';
        $fileContent = file_get_contents($audioFile);
        $fileLength = strlen($fileContent);
        $header = [
            'Content-Type: application/json'
        ];
        $post = [
            'format' => 'wav',
            'rate' => 16000,
            'channel' => 1,
            'cuid' => self::$options['cuid'] . '',
            'token' => $this->getAccessToken(),
            'speech' => base64_encode($fileContent),
            'len' => $fileLength
        ];
        $result = $this->httpRequest($url, $header, json_encode($post));
        $result = json_decode($result, true);
        if ($result['err_no'] > 0) {
            return [
                'errno' => 1,
                'message' => $result['err_msg'] ?? '解析出现错误'
            ];
        }
        if (!empty($result['result'])) {
            $text = implode('', $result['result']);
        } else {
            $text = '';
        }

        return $text;
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
            return json_encode([
                'err_no' => 1,
                'err_msg' => 'curl错误: ' . curl_error($ch)
            ]);
        }
        curl_close($ch);
        return $result;
    }

}
