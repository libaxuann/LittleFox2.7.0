<?php

namespace app\admin\controller;

use think\facade\Filesystem;

class Upload extends Base
{
    /**
     * 上传图片
     */
    public function image()
    {
        $data = input('data', '', 'trim');
        $data = @json_decode($data, true);
        $type = isset($data['type']) ? $data['type'] : '';

        $file = request()->file('file');
        $path = Filesystem::disk('public')->putFile('image', $file, 'uniqid');
        $ext = strrchr($path, '.');
        if (!in_array($ext, ['.jpg', '.jpeg', '.png', '.gif'])) {
            @unlink('./upload/' . $path);
            return errorJson('只能上传jpg/png/gif格式的图片');
        }

        // $url = saveToOss('./upload/' . $path);

        return successJson([
            'type' => $type,
            'path' => mediaUrl('./upload/' . $path, true)
        ]);
    }

    /**
     * 上传证书文件
     */
    public function pem()
    {
        $file = request()->file('file');
        $path = Filesystem::disk('public')->putFile('cert', $file, 'uniqid');
        $ext = strrchr($path, '.');
        if ($ext != '.pem') {
            @unlink('./upload/' . $path);
            return errorJson('只能上传.pem格式的文件');
        }
        $path = mediaUrl('/upload/' . $path);

        return successJson($path);
    }

    public function ueditor()
    {
        $action = input('action', '', 'trim');
        if ($action == 'config') {
            echo '{"imageActionName":"uploadimage","imageFieldName":"upfile","imageMaxSize":2048000,"imageAllowFiles":[".png",".jpg",".jpeg",".gif",".bmp"],"imageCompressEnable":true,"imageCompressBorder":1600,"imageInsertAlign":"none","imageUrlPrefix":""}';
        } elseif ($action == 'uploadimage') {
            $file = request()->file('upfile');
            $path = Filesystem::disk('public')->putFile('image', $file, 'uniqid');
            $ext = strrchr($path, '.');
            if (!in_array($ext, ['.jpg', '.jpeg', '.png', '.gif'])) {
                @unlink('./upload/' . $path);
                return errorJson('只能上传jpg/png/gif格式的图片');
            }
            $url = saveToOss('./upload/' . $path);
            echo json_encode([
                'state' => 'SUCCESS',
                'type' => $ext,
                'url' => $url
            ]);
        }
    }
}
