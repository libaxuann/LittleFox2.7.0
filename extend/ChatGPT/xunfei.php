<?php

namespace ChatGPT;

class xunfei
{
    protected static $appid = '';
    protected static $apikey = '';
    protected static $apisecret = '';
    protected static $model = '';
    protected static $temperature = 0.9;
    protected static $max_tokens = 3000;
    protected static $apis = [
        'general' => 'wss://spark-api.xf-yun.com/v1.1/chat',
        'generalv2' => 'wss://spark-api.xf-yun.com/v2.1/chat',
        'generalv3' => 'wss://spark-api.xf-yun.com/v3.1/chat'
    ];
    protected static $apiUrl = '';

    /**
     * @param $appid
     * @param $apikey
     * @param $apisecret
     * @param $model
     * @param $temperature
     * @param $max_tokens
     */
    public function __construct($appid, $apikey, $apisecret, $model, $temperature = '', $max_tokens = '')
    {
        self::$appid = $appid;
        self::$apikey = $apikey;
        self::$apisecret = $apisecret;
        self::$model = $model;
        if ($temperature) {
            self::$temperature = $temperature;
        }
        if ($max_tokens) {
            self::$max_tokens = $max_tokens;
        }
        self::$apiUrl = self::$apis[$model];
    }

    public function sendText($message = [], $replyCallback = null, $errorCallback = null)
    {
        $authUrl = $this->makeAuthUrl(self::$apiUrl);

        try {
            $client = new \WebSocket\Client($authUrl);
            if ($client) {
                $data = [
                    'header' => [
                        'app_id' => self::$appid
                    ],
                    'parameter' => [
                        'chat' => [
                            'domain' => self::$model,
                            'temperature' => floatval(self::$temperature),
                            'max_tokens' => intval(self::$max_tokens)
                        ]
                    ],
                    'payload' => [
                        'message' => [
                            'text' => $message
                        ]
                    ]
                ];
                $client->send(json_encode($data));

                while (true) {
                    $response = $client->receive();
                    $resp = json_decode($response, true);
                    if ($resp['header']['code'] == 0) {
                        $content = $resp['payload']['choices']['text'][0]['content'];
                        if ($replyCallback) {
                            $replyCallback($client, $content);
                            if ($resp['header']['status'] == 2) {
                                $replyCallback($client, 'data: [DONE]');
                                break;
                            }
                        }
                    } else {
                        if ($errorCallback) {
                            $errorCallback('出现错误：' . $response);
                        }
                        break;
                    }
                }
                $client->close();
                return null;
            } else {
                return [
                    'errno' => 1,
                    'message' => '接口连接失败'
                ];
            }
        } catch (\Exception $e) {
            return [
                'errno' => 1,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * @return string
     * 生成带认证参数的url
     */
    private function makeAuthUrl($apiUrl)
    {
        $url = parse_url($apiUrl);
        $date = gmdate('D, d M Y H:i:s') . ' GMT';
        $str = "host: " . $url['host'] . "\n";
        $str .= "date: " . $date . "\n";
        $str .= "GET " . $url['path'] . " HTTP/1.1";
        $signature = base64_encode(hash_hmac('sha256', $str, self::$apisecret, true));
        $authorization = base64_encode('api_key="' . self::$apikey . '", algorithm="hmac-sha256", headers="host date request-line", signature="' . $signature . '"');

        $query = [
            'authorization' => $authorization,
            'date' => $date,
            'host' => $url['host']
        ];
        $authUrl = $apiUrl . '?' . http_build_query($query);

        return $authUrl;
    }

    /**
     * @param $text
     * @return false|string|null
     */
    public function getEmbedding($text)
    {
        if (mb_strlen($text) > 256) {
            return '';
        }
        $url = 'http://knowledge-retrieval.cn-huabei-1.xf-yun.com/v1/aiui/embedding/query';
        $authUrl = $this->makeAuthUrl($url);
        $data = [
            'header' => [
                'app_id' => self::$appid
            ],
            'payload' => [
                'text' => $text
            ]
        ];

        $result = $this->httpRequest($authUrl, $data);
        if (isset($result['errno'])) {
            return '';
        }
        return isset($result['data'][0]['embedding']) ? json_encode($result['data'][0]['embedding']) : '';
    }

    private function httpRequest($url, $post = null)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post));
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
