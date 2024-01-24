<?php
/*
 * 此文件用于验证短信服务API接口，供开发时参考
 * 执行验证前请确保文件为utf-8编码，并替换相应参数为您自己的信息，并取消相关调用的注释
 * 建议验证前先执行Test.php验证PHP环境
 *
 * 2017/11/30
 */
namespace FoxSms;

class Aliyun {

    private $accessKeyId;
    private $accessKeySecret;
    public function __construct($accessKeyId, $accessKeySecret)
    {
        $this->accessKeyId = $accessKeyId;
        $this->accessKeySecret  = $accessKeySecret;
    }

    /**
     * @param $options
     * 发送验证码
     */
    public function send($options = []) {
        $domain = 'dysmsapi.aliyuncs.com';
        $params = [
            'PhoneNumbers' => implode(',', $options['PhoneNumbers']),
            'SignName' => $options['SignName'],
            'TemplateCode' => $options['TemplateCode'],
            'TemplateParam' => $options['TemplateParam']
        ];
        if (!empty($params['TemplateParam']) && is_array($params['TemplateParam'])) {
            $params['TemplateParam'] = json_encode($params['TemplateParam']);
        }
        $params = array_merge($params, [
            'RegionId' => 'cn-hangzhou',
            'Action' => 'SendSms',
            'Version' => '2017-05-25'
        ]);
        $result = $this->request($domain, $params);
        if ($result['Code'] = 'OK') {
            return [
                'errno' => 0
            ];
        } else {
            return [
                'errno' => 1,
                'message' => $result['Message']
            ];
        }
    }

    /**
     * 生成签名并发起请求
     *
     * @param $domain string API接口所在域名
     * @param $params array API具体参数
     * @return bool|\stdClass 返回API接口调用结果，当发生错误时返回false
     */
    private function request($domain, $params) {
        $apiParams = array_merge([
                'SignatureMethod' => 'HMAC-SHA1',
                'SignatureNonce' => uniqid(mt_rand(0,0xffff), true),
                'SignatureVersion' => '1.0',
                'AccessKeyId' => $this->accessKeyId,
                'Timestamp' => gmdate('Y-m-d\TH:i:s\Z'),
                'Format' => 'JSON'
        ], $params);
        ksort($apiParams);

        $tmp = '';
        foreach ($apiParams as $key => $value) {
            $tmp .= '&' . $this->encode($key) . '=' . $this->encode($value);
        }

        $stringToSign = 'GET&%2F&' . $this->encode(substr($tmp, 1));
        $sign = base64_encode(hash_hmac('sha1', $stringToSign, $this->accessKeySecret . '&',true));
        $signature = $this->encode($sign);
        $url = "http://{$domain}/?Signature={$signature}{$tmp}";

        try {
            $content = $this->httpRequest($url);
            return json_decode($content,true);
        } catch( \Exception $e) {
            return false;
        }
    }

    private function encode($str)
    {
        $res = urlencode($str);
        $res = preg_replace("/\+/", "%20", $res);
        $res = preg_replace("/\*/", "%2A", $res);
        $res = preg_replace("/%7E/", "~", $res);
        return $res;
    }

    private function httpRequest($url) {
        if(function_exists('curl_init')) {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_TIMEOUT, 5);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_HTTPHEADER, [
                    'x-sdk-client' => 'php/2.0.0'
            ]);
            $rtn = curl_exec($ch);

            if($rtn === false) {
                trigger_error('[CURL_' . curl_errno($ch) . ']: ' . curl_error($ch), E_USER_ERROR);
            }
            curl_close($ch);

            return $rtn;
        }

        $context = stream_context_create(array(
            'http' => [
                'method' => 'GET',
                'header' => ['x-sdk-client: php/2.0.0']
            ]
        ));

        return file_get_contents($url, false, $context);
    }
}
