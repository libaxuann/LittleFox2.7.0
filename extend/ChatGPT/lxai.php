<?php

namespace ChatGPT;

class lxai
{
    protected static $model = 'gpt-3.5-turbo';
    protected static $apiKey = '';
    protected static $chatApiHost = 'http://chat.80w.top:8010';
    protected static $drawApiHost = 'http://mj.80w.top:8606';
    protected static $temperature = 0.9;
    protected static $max_tokens = 2000;

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

    /**
     * @param string $message
     * @return array
     * GPT3.5以上模型
     * 流式输出
     */
    public function sendText($message = [], $callback = null)
    {
        $url = self::$chatApiHost . '/v1/chat/completions';
        $post = [
            'messages' => $message,
            'max_tokens' => self::$max_tokens,
            'temperature' => self::$temperature,
            'model' => self::$model,
            'frequency_penalty' => 0,
            'presence_penalty' => 0.6,
            'stream' => true
        ];
        return $this->httpRequest($url, $post, $callback);
    }

    /**
     * @param $option
     * @return array
     * 提交MJ绘画任务
     */
    public function drawMJ($option = [])
    {
        $url = self::$drawApiHost . '/mj/trigger/submit';
        $post = [
            'action' => 'IMAGINE',
            'prompt' => $option['prompt'],
        ];
        if (!empty($option['imageurl'])) {
            $post['imageurl'] = $option['imageurl'];
        }
        if (!empty($option['notifyHook'])) {
            $post['notifyHook'] = $option['notifyHook'];
        }

        $result = $this->httpRequest($url, $post);
        if (!empty($result['code']) && $result['code'] == 1) {
            return [
                'errno' => 0,
                'data' => $result['result']
            ];
        } else {
            return [
                'errno' => 1,
                'message' => $result['description'] ?? '任务提交失败'
            ];
        }
    }

    /**
     * @param $option
     * @return array
     * MJ图片放大、变换
     */
    public function mjCtrl($option = [])
    {
        $url = self::$drawApiHost . '/mj/trigger/submit-uv';
        $post = [
            'id' => $option['id'],
            'type' => $option['type'],
            'index' => $option['index'],
            'notifyHook' => $option['notifyHook']
        ];

        $result = $this->httpRequest($url, $post);

        if (!empty($result['code']) && $result['code'] == 1) {
            return [
                'errno' => 0,
                'data' => $result['result']
            ];
        } else {
            return [
                'errno' => 1,
                'message' => $result['description'] ?? '任务提交失败'
            ];
        }
    }

    /**
     * @param $imageUrl
     * @return array
     * 分割mj的4张图片
     */
    public function splitMjImage($imageUrl)
    {
        $images = [];

        $date = date('Ymd');
        $dir = './upload/draw/' . $date . '/';
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        $filename = uniqid();
        $filepath = $dir . $filename . '.jpg';
        $filepath1 = $dir . $filename . '_1.jpg';
        $filepath2 = $dir . $filename . '_2.jpg';
        $filepath3 = $dir . $filename . '_3.jpg';
        $filepath4 = $dir . $filename . '_4.jpg';

        if (strpos($imageUrl, '.webp') !== false) {
            $srcResource = imagecreatefromwebp($imageUrl);
        } elseif (strpos($imageUrl, '.png') !== false) {
            $srcResource = imagecreatefrompng($imageUrl);
        } elseif (strpos($imageUrl, '.jpg') !== false) {
            $srcResource = imagecreatefromjpeg($imageUrl);
        }

        $width = imagesx($srcResource);
        $height = imagesy($srcResource);
        if ($width < 2048 && $height < 2048) {
            imagejpeg($srcResource, $filepath, 100);
            $images[] = saveToOss($filepath);
        } else {
            $newWidth = intval($width / 2);
            $newHeight = intval($height / 2);
            $newImage = imagecreatetruecolor($newWidth, $newHeight);
            // 第1张图片
            imagecopyresampled($newImage, $srcResource, 0, 0, 0, 0, $newWidth, $newHeight, $newWidth, $newHeight);
            imagejpeg($newImage, $filepath1, 100);
            $images[] = saveToOss($filepath1);
            // 第2张图片
            imagecopyresampled($newImage, $srcResource, 0, 0, $newWidth, 0, $newWidth, $newHeight, $newWidth, $newHeight);
            imagejpeg($newImage, $filepath2, 100);
            $images[] = saveToOss($filepath2);
            // 第3张图片
            imagecopyresampled($newImage, $srcResource, 0, 0, 0, $newHeight, $newWidth, $newHeight, $newWidth, $newHeight);
            imagejpeg($newImage, $filepath3, 100);
            $images[] = saveToOss($filepath3);
            // 第4张图片
            imagecopyresampled($newImage, $srcResource, 0, 0, $newWidth, $newHeight, $newWidth, $newHeight, $newWidth, $newHeight);
            imagejpeg($newImage, $filepath4, 100);
            $images[] = saveToOss($filepath4);
            imagedestroy($newImage);
            imagedestroy($srcResource);
        }

        return $images;
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

        $usageUrl = self::$drawApiHost . '/v1/dashboard/billing/usage?start_date=' . $startDate . '&end_date=' . $endDate;
        $subUrl = self::$drawApiHost . '/v1/dashboard/billing/subscription';


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

    public function uploadImage($imgpath)
    {
        $url = self::$drawApiHost . '/mj/trigger/upload';
        $fileName = pathinfo($imgpath)['basename'];

        // 获取图片MIME类型
        $fi = new \finfo(FILEINFO_MIME_TYPE);
        $mimeType = $fi->file($imgpath);
        $boundary = uniqid(); //分割符号
        // 请求头
        $header[] = 'accept:application/json';
        $header[] = 'Content-Type:multipart/form-data;boundary=' . $boundary;
        $header[] = 'type=' . $mimeType;
        $header[] = 'key=' . self::$apiKey;

        $data = "--{$boundary}\r\n";
        $data .= 'Content-Disposition: form-data; name="file"; filename="' . $fileName . '"' . "\r\n";
        $data .= 'Content-Type:'.$mimeType . "\r\n";
        $data .= "\r\n";
        $data .= (fread(fopen($imgpath, 'rb'), filesize($imgpath))) . "\r\n";
        $data .= "--{$boundary}--\r\n";

        $data2 = "--{$boundary}\r\n";
        $data2 .= 'Content-Disposition: form-data; name="file"; filename="' . $fileName . '"' . "\r\n";
        $data2 .= 'Content-Type:'.$mimeType . "\r\n";
        $data2 .= "--{$boundary}--\r\n";

        $result = $this->httpUpload($url, $header, $data);

        $info = @json_decode($result, JSON_UNESCAPED_UNICODE);
        return $info;
    }

    public function queryDrawResult($task_id)
    {
        $url = self::$drawApiHost . '/mj/task/' . $task_id . '/fetch';

        $result = $this->httpRequest($url);
        if (!empty($result) && isset($result['status'])) {
            if ($result['status'] === 'SUCCESS') {
                return [
                    'errno' => 0,
                    'data' => $result['imageUrl']
                ];
            } elseif ($result['status'] === 'FAILURE') {
                return [
                    'errno' => 1,
                    'message' => $result['description'] ?? ''
                ];
            }
        }

        return [
            'errno' => 1,
            'message' => '生成失败.'
        ];
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
        curl_setopt($ch, CURLOPT_TIMEOUT, 300);
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
        $ret = curl_exec($ch);
        if (false === $ret) {
            return curl_errno($ch);
        }
        curl_close($ch);

        return @json_decode($ret, true);
    }
}
