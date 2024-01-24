<?php

namespace ChatGPT;

class openai
{
    protected static $model = 'gpt-3.5-turbo';
    protected static $apiKey = '';
    protected static $apiHost = 'https://api.openai.com';
    protected static $temperature = 0.9;
    protected static $max_tokens = 1500;

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
        $url = self::$apiHost . '/v1/chat/completions';
        $post = [
            'messages' => $message,
            'max_tokens' => intval(self::$max_tokens),
            'temperature' => floatval(self::$temperature),
            'model' => self::$model,
            'frequency_penalty' => 0,
            'presence_penalty' => 0.6,
            'stream' => true
        ];
        $result = $this->httpRequest($url, $post, $callback);

        return $this->handleError($result);
    }



    private function parseError($data)
    {
        $data = @json_decode($data);
        if (empty($data)) {
            return null;
        }

        $level = 'warning';
        $errorMsg = '';
        if (isset($data->error)) {
            // openai
            if (isset($data->error->code) && $data->error->code == 'invalid_api_key') {
                $level = 'error';
                $errorMsg = 'key不正确';
            } else {
                $errorMsg = $data->error->message;
                if (strpos($errorMsg, 'Incorrect API key provided') !== false) {
                    $level = 'error';
                    $errorMsg = 'key不正确。' . $errorMsg;
                } elseif (strpos($errorMsg, 'deactivated account') !== false) {
                    $level = 'error';
                    $errorMsg = 'key账号被封。' . $errorMsg;
                } elseif (strpos($errorMsg, 'has been deactivated') !== false) {
                    $level = 'error';
                    $errorMsg = 'key已停用。' . $errorMsg;
                } elseif (strpos($errorMsg, 'exceeded your current quota') !== false) {
                    $level = 'error';
                    $errorMsg = 'key余额不足。' . $errorMsg;
                } elseif (strpos($errorMsg, 'Your account is not active') !== false) {
                    $level = 'error';
                    $errorMsg = '账号已停用。' . $errorMsg;
                } elseif (strpos($errorMsg, 'thus not supported') !== false) {
                    $level = 'error';
                    $errorMsg = 'key不支持此模型。' . $errorMsg;
                } elseif (strpos($errorMsg, 'Rate limit reached') !== false) {
                    $errorMsg = '接口繁忙，请稍后重试';
                }
            }
        } elseif (isset($data->object) && $data->object == 'error') {
            // api2d
            $errorMsg = $data->message;
            if (strpos($errorMsg, 'Not enough point') !== false) {
                $level = 'error';
                $errorMsg = 'key余额不足。' . $errorMsg;
            } elseif (strpos($errorMsg, 'bad forward key') !== false) {
                $level = 'error';
                $errorMsg = 'key不正确。' . $errorMsg;
            }
        }

        return [
            'level' => $level,
            'message' => $errorMsg
        ];
    }

    public function draw($option = [])
    {
        $url = self::$apiHost . '/v1/images/generations';
        $result = $this->httpRequest($url, $option);
        // 格式化报错
        $error = $this->handleError($result);
        if (!empty($error) && !empty($error['errno'])) {
            return $error;
        }

        return [
            'errno' => 0,
            'data' => $result['data']
        ];
    }

    public function getModelList()
    {
        $url = self::$apiHost . '/v1/models';
        return $this->httpRequest($url);
    }

    public function getEmbedding($text)
    {
        $url = self::$apiHost . '/v1/embeddings';
        $post = [
            'model' => 'text-embedding-ada-002',
            'input' => $text
        ];

        $result = $this->httpRequest($url, $post);
        // 格式化报错
        $error = $this->handleError($result);
        if (!empty($error) && !empty($error['errno'])) {
            return null;
        }
        return isset($result['data'][0]['embedding']) ? json_encode($result['data'][0]['embedding']) : '';
    }

    /**
     * @return array|mixed
     * 查询账户余额
     */
    public function getBalance()
    {
        $now = time();
        $startDate = date('Y-m-01', $now);
        $endDate = date('Y-m-d', $now);

        $usageUrl = self::$apiHost . '/v1/dashboard/billing/usage?start_date=' . $startDate . '&end_date=' . $endDate;
        $subUrl = self::$apiHost . '/v1/dashboard/billing/subscription';

        $result = $this->httpRequest($usageUrl);
        $total_used = round($result['total_usage'] / 100, 3);

        $result = $this->httpRequest($subUrl);
        $total_granted = round($result['hard_limit_usd'], 3);
        $total_available = round(($total_granted * 1000 - $total_used * 1000) / 1000, 3);

        return [
            'total_granted' => $total_granted,
            'total_used' => $total_used,
            'total_available' => $total_available
        ];
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
                'message' => $result['error']['message']
            ];
        }
        // api2d的错误
        elseif (isset($result['object']) && $result['object'] == 'error') {
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
