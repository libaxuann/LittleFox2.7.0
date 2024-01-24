<?php

namespace ChatGPT;

class replicate
{
    protected static $apiHost = 'https://api.replicate.com';
    protected static $token = '';
    protected static $pageStartTime = 0;

    public function __construct($token = '')
    {
        self::$token = $token;
    }

    public function draw($option = [])
    {
        self::$pageStartTime = microtime(true);

        $url = self::$apiHost . '/v1/predictions';
        $post = [
            'version' => '9936c2001faa2194a261c01381f90e65261879985476014a0a37a334593a05eb',
            'input' => [
                'prompt' => 'mdjrny-v4 style design a ' . $option['prompt'],
                'num_outputs' => 1
            ]
        ];

        $result = $this->httpRequest($url, json_encode($post));

        if (!empty($result['detail'])) {
            return [
                'errno' => 1,
                'message' => $result['detail']
            ];
        }
        if (isset($result['error']) && $result['error'] == 1) {
            return [
                'errno' => 1,
                'message' => $result['message']
            ];
        }
        if (!isset($result['id'])) {
            return [
                'errno' => 1,
                'message' => '任务提交失败，请重试'
            ];
        }

        return $this->queryDrawResult($result['id']);
    }

    private function queryDrawResult($id)
    {
        $url = self::$apiHost . '/v1/predictions/' . $id;

        $result = $this->httpRequest($url);
        if (!empty($result['detail'])) {
            return [
                'errno' => 1,
                'message' => $result['detail']
            ];
        }
        if (isset($result['status']) && $result['status'] === 'succeeded') {
            return [
                'errno' => 0,
                'data' => $result['output']
            ];
        }

        $runtime = $this->getRunTime();
        if ($runtime < 180) {
            usleep(5000000);
            return $this->queryDrawResult($id);
        }
        return [
            'errno' => 1,
            'message' => '生成失败'
        ];
    }

    private function getRunTime()
    {
        $etime = microtime(true);
        $total = $etime - self::$pageStartTime;
        return round($total, 4);
    }

    /**
     * http请求
     */
    protected function httpRequest($url, $post = '')
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: token ' . self::$token
        ]);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
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
        return json_decode($result, true);
    }
}
