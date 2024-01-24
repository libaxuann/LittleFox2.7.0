<?php

namespace FileStorage;

use OSS\OssClient;
use OSS\Core\OssException;

class alioss
{
    protected $accessKeyId;
    protected $accessKeySecret;
    protected $endpoint;
    protected $bucket;
    protected $domain;
    protected $ossClient;

    public function __construct($config)
    {
        $this->accessKeyId = $config['access_key_id'];
        $this->accessKeySecret = $config['access_key_secret'];
        $this->endpoint = $config['endpoint'];
        $this->bucket = $config['bucket'];
        $this->domain = rtrim($config['domain'], '/');
        $this->ossClient = new OssClient($this->accessKeyId, $this->accessKeySecret, $this->endpoint);

        return $this;
    }

    public function upload($objectName, $filePath)
    {
        try {
            $upload = $this->ossClient->uploadFile($this->bucket, $objectName, $filePath);
        } catch (OssException $e) {
            return [
                'errno' => 1,
                'message' => $e->getMessage()
            ];
        }
        if (!isset($upload['info']['url'])) {
            return [
                'errno' => 1,
                'message' => '保存失败'
            ];
        }

        $url = $upload['info']['url'];
        if (!empty($this->domain)) {
            $urlInfo = parse_url($url);
            $url = str_replace(($urlInfo['scheme'] . '://' . $urlInfo['host']), $this->domain, $url);
        }
        return [
            'errno' => 0,
            'url' => $url
        ];
    }
}
