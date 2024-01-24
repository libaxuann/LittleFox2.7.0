<?php

namespace FileStorage;

use Qcloud\Cos\Client;

class txcos
{
    protected $secretId;
    protected $secretKey;
    protected $region;
    protected $bucket;
    protected $domain;
    protected $schema = 'http';
    protected $cosClient;

    public function __construct($config)
    {
        $this->secretId = $config['secret_id'];
        $this->secretKey = $config['secret_key'];
        $this->region = $config['region'];
        $this->bucket = $config['bucket'];
        $this->domain = $config['domain'];
        $this->cosClient = new Client([
            'region' => $this->region,
            'schema' => $this->schema,
            'credentials' => [
                'secretId' => $this->secretId,
                'secretKey' => $this->secretKey
            ]
        ]);

        return $this;
    }

    public function upload($objectName, $filePath)
    {
        try {
            $key = $objectName;
            $file = fopen($filePath, 'rb');
            if ($file) {
                $result = $this->cosClient->putObject([
                    'Bucket' => $this->bucket,
                    'Key' => $key,
                    'Body' => $file
                ]);

                $result = (array)$result;
                foreach ($result as $item) {
                    $result = $item;
                    break;
                }
            } else {
                return [
                    'errno' => 1,
                    'message' => '文件信息有误'
                ];
            }
        } catch (\Exception $e) {
            return [
                'errno' => 1,
                'message' => $e->getMessage()
            ];
        }
        if (!isset($result['Location'])) {
            return [
                'errno' => 1,
                'message' => '保存失败'
            ];
        }

        if(!empty($this->domain)) {
            $url = rtrim($this->domain, '/') . '/' . $result['Key'];
        } else {
            $url = $this->schema . '://' . $result['Location'];
        }

        return [
            'errno' => 0,
            'url' => $url
        ];
    }
}
