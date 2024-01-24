<?php

namespace app\web\controller;
use think\facade\Filesystem;

class Upload extends Base
{
    /**
     *上传图片
     */
    public function image()
    {
        try {
            $file = request()->file('image');
            $path = Filesystem::disk('public')->putFile('image', $file, 'uniqid');
            $ext = strrchr($path, '.');
            if (!in_array($ext, ['.jpg', '.jpeg', '.png', '.gif'])) {
                @unlink('./upload/' . $path);
                return errorJson('只能上传jpg/png/gif格式的图片');
            }
            $url = saveToOss('./upload/' . $path);
            return successJson([
                'path' => $url
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }
}
