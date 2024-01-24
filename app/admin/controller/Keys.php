<?php

namespace app\admin\controller;

use think\facade\Db;

class Keys extends Base
{
    public function getKeyList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $type = input('type', 'openai', 'trim');
        $keyword = input('keyword', '', 'trim');
        $where = [
            ['site_id', '=', self::$site_id],
            ['type', '=', $type]
        ];
        if ($keyword) {
            $where[] = ['key|remark', 'like', '%' . $keyword . '%'];
        }
        try {
            $list = Db::name('keys')
                ->where($where)
                ->order('id desc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    if ($item['type'] == 'wenxin') {
                        $temp = explode('|', $item['key']);
                        $item['apikey'] = $temp[0];
                        $item['secretkey'] = $temp[1] ?? '';
                        $item['apikey'] = substr_replace($item['apikey'], '*****', 5, 10);
                        $item['secretkey'] = substr_replace($item['secretkey'], '*****', 5, 10);
                        unset($item['key']);
                    } elseif ($item['type'] == 'azure') {
                        $temp = explode('|', $item['key']);
                        $item['secret'] = $temp[0];
                        $item['apiurl'] = $temp[1] ?? '';
                        $item['secret'] = substr_replace($item['secret'], '*****', 5, 10);
                        unset($item['key']);
                    } elseif ($item['type'] == 'hunyuan') {
                        $temp = explode('|', $item['key']);
                        $item['appid'] = $temp[0];
                        $item['secretid'] = $temp[1];
                        $item['secretkey'] = $temp[2] ?? '';
                        $item['secretid'] = substr_replace($item['secretid'], '*****', 5, 10);
                        $item['secretkey'] = substr_replace($item['secretkey'], '*****', 5, 10);
                        unset($item['key']);
                    } elseif ($item['type'] == 'xunfei') {
                        $temp = explode('|', $item['key']);
                        $item['appid'] = $temp[0];
                        $item['apisecret'] = $temp[1] ?? '';
                        $item['apikey'] = $temp[2] ?? '';
                        $item['apisecret'] = substr_replace($item['apisecret'], '*****', 5, 10);
                        $item['apikey'] = substr_replace($item['apikey'], '*****', 5, 10);
                        unset($item['key']);
                    } elseif ($item['type'] == 'minimax') {
                        $temp = explode('|', $item['key']);
                        $item['groupid'] = $temp[0];
                        $item['apikey'] = $temp[1] ?? '';
                        $item['apikey'] = substr($item['apikey'], 0, 6) . '...' . substr($item['apikey'], -6);
                        unset($item['key']);
                    } elseif ($item['type'] == 'yijian') {
                        $temp = explode('|', $item['key']);
                        $item['apikey'] = $temp[0];
                        $item['apisecret'] = $temp[1] ?? '';
                        $item['apikey'] = substr_replace($item['apikey'], '*****', 5, 10);
                        $item['apisecret'] = substr_replace($item['apisecret'], '*****', 5, 10);
                        unset($item['key']);
                    } else {
                        $item['key'] = substr_replace($item['key'], '*****', 8, 13);
                    }
                    return $item;
                });
            $count = Db::name('keys')
                ->where($where)
                ->count();
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    /**
     * @return string
     * 新增key
     */
    public function saveKey()
    {
        $type = input('type', 'openai', 'trim');
        $key = input('key', '', 'trim');
        $remark = input('remark', '', 'trim');

        $rs = Db::name('keys')
            ->where([
                ['site_id', '=', self::$site_id],
                ['type', '=', $type],
                ['key', '=', $key]
            ])
            ->find();
        if ($rs) {
            return errorJson('Key已存在');
        }

        try {
            Db::name('keys')
                ->insert([
                    'site_id' => self::$site_id,
                    'type' => $type,
                    'key' => $key,
                    'state' => 1,
                    'remark' => $remark,
                    'create_time' => time()
                ]);
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 删除key
     */
    public function delKey()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('keys')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->delete();
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 设置状态
     */
    public function setKeyState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        $state = $state ? 1 : 0;
        try {
            Db::name('keys')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'state' => $state,
                    'stop_reason' => $state ? '' : text('手动停止')
                ]);
            return successJson('', '设置成功');
        } catch (\Exception $e) {
            return errorJson(text('设置失败') . ': ' . $e->getMessage());
        }
    }
}
