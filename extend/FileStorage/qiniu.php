<?php

namespace FileStorage;

use Qiniu\Auth;
use Qiniu\Storage\UploadManager;

class qiniu
{
    protected $accessKey;
    protected $secretKey;
    protected $bucket;
    protected $domain;
    protected $auth;

    public function __construct($config)
    {
        $this->accessKey = $config['access_key'];
        $this->secretKey = $config['secret_key'];
        $this->bucket = $config['bucket'];
        $this->domain = rtrim($config['domain'], '/');
        $this->auth = new Auth($this->accessKey, $this->secretKey);

        return $this;
    }

    public function upload($objectName, $filePath)
    {
        $token = $this->auth->uploadToken($this->bucket);
        $uploadMgr = new UploadManager();
        list($result, $error) = $uploadMgr->putFile($token, $objectName, $filePath);
        if ($error !== null) {
            return [
                'errno' => 1,
                'message' => '保存失败'
            ];
        } else {
            return [
                'errno' => 0,
                'url' => $this->domain . '/' . $result['key'],
            ];
        }
    }
}
