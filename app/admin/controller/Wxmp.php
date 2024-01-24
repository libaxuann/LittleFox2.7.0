<?php

namespace app\admin\controller;

use think\facade\Db;

class Wxmp extends Base
{
    public function getWxmpSetting()
    {
        $setting = getSystemSetting(self::$site_id, 'wxmp');
        if (!$setting || count($setting) == 0) {
            $setting = [
                'title' => '',
                'appid' => '',
                'appsecret' => '',
                'token' => getNonceStr(32),
                'aes_key' => getNonceStr(43),
                'server_url' => 'https://' . $_SERVER['HTTP_HOST'] . '/web.php/wxmp/server/site/' . self::$site_id
            ];
        }

        return successJson($setting);
    }

    public function setWxmpSetting()
    {
        $data = input('data', '', 'trim');
        $data = json_decode($data, true);

        // 加上自动回复设置
        $setting = getSystemSetting(self::$site_id, 'wxmp');
        if (!empty($setting['defaultReply'])) {
            $data['defaultReply'] = $setting['defaultReply'];
        }
        if (!empty($setting['welcomeReply'])) {
            $data['welcomeReply'] = $setting['welcomeReply'];
        }
        $data = json_encode($data);

        $res = setSystemSetting(self::$site_id, 'wxmp', $data);

        if ($res) {
            return successJson('', '保存成功');
        } else {
            return errorJson('保存失败，请重试！');
        }
    }

    public function getWxmpReply()
    {
        $type = input('type', 'defaultReply', 'trim');
        $setting = getSystemSetting(self::$site_id, 'wxmp');
        if(empty($setting[$type])) {
            return successJson([
                'type' => 'text',
                'content' => ''
            ]);
        } else {
            return successJson($setting[$type]);
        }
    }

    public function setWxmpReply()
    {
        $type = input('type', 'defaultReply', 'trim');
        $data = input('data', '', 'trim');
        $data = json_decode($data, true);
        if ($data['type'] == 'image' && !empty($data['image'])) {
            $mediaId = $this->uploadToWxmp($data['image']);
            $data['media_id'] = $mediaId;
        }

        // 加上其他设置
        $setting = getSystemSetting(self::$site_id, 'wxmp');
        $setting[$type] = $data;
        $setting = json_encode($setting);

        $res = setSystemSetting(self::$site_id, 'wxmp', $setting);

        if ($res) {
            return successJson('', '保存成功');
        } else {
            return errorJson('保存失败，请重试！');
        }
    }

    public function getKeywordList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 100, 'intval');

        try {
            $list = Db::name('wxmp_keyword')
                ->where('site_id', self::$site_id)
                ->page($page, $pagesize)
                ->order('weight desc')
                ->select()->toArray();
            $count = Db::name('wxmp_keyword')
                ->where('site_id', self::$site_id)
                ->count();
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    public function getKeyword()
    {
        $id = input('id', 0, 'intval');

        try {
            $keyword = Db::name('wxmp_keyword')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->find();
            if (!$keyword) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            return successJson($keyword);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveKeyword()
    {
        $id = input('id', 0, 'intval');
        $keyword = input('keyword', '', 'trim');
        $is_hit = input('is_hit', 1, 'intval');
        $type = input('type', 'text', 'trim');
        $content = input('content', '', 'trim');
        $image = input('image', '', 'trim');
        $weight = input('weight', 100, 'intval');

        $rs = Db::name('wxmp_keyword')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '<>', $id],
                ['keyword', '=', $keyword]
            ])
            ->find();
        if ($rs) {
            return errorJson('关键词已存在');
        }

        // 图片上传到公众号资源库
        if ($type == 'image' && !empty($image)) {
            $mediaId = $this->uploadToWxmp($image);
        }

        $data = [
            'keyword' => $keyword,
            'type' => $type,
            'content' => $content,
            'image' => $image,
            'is_hit' => $is_hit,
            'weight' => $weight
        ];
        if (!empty($mediaId)) {
            $data['media_id'] = $mediaId;
        }

        try {
            if ($id) {
                Db::name('wxmp_keyword')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('wxmp_keyword')
                    ->insert($data);
            }

            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    // 上传图片到公众号素材库
    private function uploadToWxmp($image)
    {
        try {
            // 图片先保存到本地
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $image);    // 请求地址
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);    // 不直接输出信息
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            $result = curl_exec($ch);
            curl_close($ch);
            $imgName = trim(strrchr($image, '/'), '/');
            $imagePath = './upload/image/' . uniqid() . $imgName;
            $fp = fopen($imagePath, 'w');
            fwrite($fp, $result);

            if (!file_exists($imagePath)) {
                return errorJson('获取图片资源失败，请重试');
            }

            // 上传到素材库
            $wxmpSetting = getSystemSetting(self::$site_id, 'wxmp');
            if (empty($wxmpSetting['appid']) || empty($wxmpSetting['appsecret'])) {
                return errorJson('请先配置公众号参数');
            }
            $config = [
                'app_id' => $wxmpSetting['appid'] ?? '',
                'secret' => $wxmpSetting['appsecret'] ?? '',
                'token' => $wxmpSetting['token'] ?? '',
                'aes_key' => $wxmpSetting['aes_key'] ?? '',
                'response_type' => 'array'
            ];

            $app = \EasyWeChat\Factory::officialAccount($config);
            $result = $app->material->uploadImage($imagePath);
            if (isset($result['media_id'])) {
                @unlink($imagePath);
                return $result['media_id'];
            } else {
                return errorJson(text('上传图片到公众号素材库失败') . ': ' . $result['errmsg']);
            }

        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * 设置关键词状态
     */
    public function setKeywordState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        $res = Db::name('wxmp_keyword')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $id]
            ])
            ->update([
                'state' => $state ? 1 : 0
            ]);
        if ($res !== false) {
            return successJson('', '设置成功');
        } else {
            return errorJson('设置失败，请重试！');
        }
    }

    /**
     * 删除留言
     */
    public function delKeyword()
    {
        $id = input('id', 0, 'intval');
        $res = Db::name('wxmp_keyword')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $id]
            ])
            ->delete();
        if ($res !== false) {
            return successJson('', '删除成功');
        } else {
            return errorJson('删除失败，请重试！');
        }
    }

}
