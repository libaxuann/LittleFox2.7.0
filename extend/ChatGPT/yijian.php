<?php

namespace ChatGPT;

class yijian
{
    protected static $apihost = 'http://api.yjai.art:8080';
    protected static $apikey = '';
    protected static $apisecret = '';

    /**
     * @param $apikey
     * @param $apisecret
     */
    public function __construct($apikey = '', $apisecret = '')
    {
        self::$apikey = $apikey;
        self::$apisecret = $apisecret;
    }

    /**
     * @param $option
     * @return array|mixed
     * 开启一个绘画任务
     */
    public function submitDrawTask($option = [])
    {
        $url = self::$apihost . '/painting-open-api/site/put_task';
        $post = [
            'prompt' => $option['prompt'] ?? '',
            'ratio' => $option['ratio'] ?? 0,
            'style' => $option['style'] ?? '',
            'guidence_scale' => $option['guidence_scale'] ?? 7.5,
            'engine' => $option['engine'] ?? '',
            'callback_url' => $option['callback_url'] ?? '',
            'callback_type' => 'end',
            'enable_face_enhance' => false,
            'is_last_layer_skip' => false,
            'steps_mode' => 0,
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];
        if (!empty($option['init_image'])) {
            $post['init_image'] = $option['init_image'];
            $post['init_strength'] = 50;
        }

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @param $uuid
     * @return array|mixed
     * 获取某个任务的详情
     */
    public function getTaskDetail($uuid)
    {
        $url = self::$apihost . '/painting-open-api/site/show_task_detail';
        $post = [
            'uuid' => $uuid,
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @param array $uuids
     * @return array|mixed
     * 批量获取任务的详情
     */
    public function getTaskDetailBatch(array $uuids)
    {
        $url = self::$apihost . '/painting-open-api/site/show_task_detail_batch';
        $post = [
            'uuids' => json_encode($uuids),
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @param $page
     * @param $page_size
     * @return array|mixed
     * 获取完成的任务
     */
    public function getCompleteTasks($page = 1, $page_size = 10)
    {
        $url = self::$apihost . '/painting-open-api/site/show_complete_tasks';
        $post = [
            'page' => $page,
            'page_size' => $page_size,
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @param $uuid
     * @return array|mixed
     * 取消排队
     */
    public function cancelTask($uuid)
    {
        $url = self::$apihost . '/painting-open-api/site/cancel_task';
        $post = [
            'uuid' => $uuid,
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @return array|mixed
     * 获取风格画家4
     */
    public function getDrawSelector()
    {
        $url = self::$apihost . '/painting-open-api/site/get_draw_selector4';
        $post = [
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @return array|mixed
     * 获取用户信息
     */
    public function getUserInfo()
    {
        $url = self::$apihost . '/painting-open-api/site/getUserInfo';
        $post = [
            'apikey' => self::$apikey,
            'timestamp' => time()
        ];

        $result = $this->httpRequest($url, $post);
        if ($result['status'] == 0) {
            return [
                'errno' => 0,
                'data'=> $result['data']
            ];
        } else {
            return [
                'errno' => 1,
                'message'=> $result['reason']
            ];
        }
    }

    /**
     * @param $params
     * @return string
     * 计算签名
     */
    private function makeSign($params = [])
    {
        $params['apikey'] = self::$apikey;
        $params['apisecret'] = self::$apisecret;
        if (!isset($params['timestamp'])) {
            $params['timestamp'] = time();
        }

        ksort($params);
        $query = $this->toUrlQuery($params);

        return strtolower(md5($query));
    }

    private function toUrlQuery($params)
    {
        $query = '';
        foreach ($params as $k => $v)
        {
            if(!empty($v) && !is_array($v)) {
                $query .= $k . '=' . $v . '&';
            }
        }
        $query = trim($query, "&");

        return $query;
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
            'Content-Type: application/x-www-form-urlencoded',
            'sign: ' . $this->makeSign($post)
        ]);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $this->toUrlQuery($post));
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
