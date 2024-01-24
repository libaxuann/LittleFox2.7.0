<?php

namespace ChatGPT;

class wenxin
{
    protected static $model = 'ERNIE-Bot-turbo';
    protected static $apikey = '';
    protected static $secretkey = '';
    protected static $temperature = 0.95;
    protected static $apis = [
        'ERNIE-Bot' => 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions',
        'ERNIE-Bot-turbo' => 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/eb-instant',
        'ERNIE-Bot-4' => 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions_pro',
        'Llama-2-13b-chat' => 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/llama_2_13b',
        'Llama-2-70b-chat' => 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/llama_2_70b',
        'ChatGLM2-6B-32K' => 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/chatglm2_6b_32k'
    ];

    /**
     * sdk constructor.
     * @param string $apikey
     * @param string $secretkey
     */
    public function __construct($apikey, $secretkey, $model = '', $temperature = '')
    {
        self::$apikey = $apikey;
        self::$secretkey = $secretkey;
        if ($temperature) {
            self::$temperature = $temperature;
        }
        if ($model && isset(self::$apis[$model])) {
            self::$model = $model;
        }
    }

    public function getAccessToken()
    {
        // 读取存储的 access_token
        $now = time();
        $accessTokenFile = __DIR__ . '/wenxin_access_token_' . self::$apikey . '.php';
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
     * @param $message
     * @param $callback
     * @return array|mixed
     * ERNIE-Bot
     */
    public function sendText($message = [], $system = '', $callback = null)
    {
        $url = self::$apis[self::$model] . '?access_token=' . $this->getAccessToken();
        $post = [
            'messages' => $message,
            'stream' => true
        ];
        // system参数仅支持ERNIE-Bot、ERNIE-Bot-turbo、ERNIE-Bot-4模型
        if (in_array(self::$model, ['ERNIE-Bot', 'ERNIE-Bot-turbo', 'ERNIE-Bot-4'])) {
            $post['temperature'] = floatval(self::$temperature);
            if ($system) {
                $post['system'] = $system;
            }
        }
        $result = $this->httpRequest($url, $post, $callback);

        return $this->handleError($result);
    }

    /**
     * @param $text
     * @return false|string
     */
    public function getEmbedding($text)
    {
        if (mb_strlen($text) > 384) {
            return '';
        }
        $url = 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/embeddings/embedding-v1?access_token=' . $this->getAccessToken();

        $post = [
            'input' => [$text]
        ];

        $result = $this->httpRequest($url, $post);
        $result = $this->handleError($result);
        if (isset($result['errno'])) {
            return '';
        }
        return isset($result['data'][0]['embedding']) ? json_encode($result['data'][0]['embedding']) : '';
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
        if (isset($result['error_code'])) {
            return [
                'errno' => 1,
                'message' => $result['error_msg']
            ];
        }
        if (isset($result['error'])) {
            return [
                'errno' => 1,
                'message' => $result['error']['message']
            ];
        }
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
            'Content-Type: application/json'
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
