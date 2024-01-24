<?php

namespace app\super\controller;

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

        return successJson([
            'type' => $type,
            'path' => mediaUrl('/upload/' . $path, true)
        ]);
    }
}
