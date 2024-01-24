<?php

namespace app\super\controller;

use think\facade\Db;

class Site extends Base
{
    public function getList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        try {
            $list = Db::name('site')
                ->where('is_delete', 0)
                ->order('id desc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    if ($item['expire_time']) {
                        $item['expire_time'] = date('Y-m-d', $item['expire_time']);
                    } else {
                        $item['expire_time'] = text('长期');
                    }
                    if ($item['last_time']) {
                        $item['last_time'] = date('Y-m-d H:i', $item['last_time']);
                    }
                    $item['create_time'] = date('Y-m-d H:i', $item['create_time']);
                    return $item;
                });
            $count = Db::name('site')
                ->where('is_delete', 0)
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
     * 取单个站点
     */
    public function getInfo()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('site')
                ->where('id', $id)
                ->field('id,title,phone,password,expire_time,remark')
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            if ($info['expire_time']) {
                $info['expire_time'] = date('Y-m-d', $info['expire_time']);
            } else {
                $info['expire_time'] = '';
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * @return string
     * 更新或新建站点
     */
    public function saveInfo()
    {
        $id = input('id', 0, 'intval');
        $title = input('title', '', 'trim');
        $phone = input('phone', '', 'trim');
        $password = input('password', '', 'trim');
        $expire_time = input('expire_time', '', 'trim');
        $remark = input('remark', '', 'trim');
        $rs = Db::name('site')
            ->where([
                ['id', '<>', $id],
                ['phone', '=', $phone]
            ])
            ->find();
        if ($rs) {
            return errorJson('账号重复，请更换');
        }
        if ($expire_time) {
            $expire_time = strtotime($expire_time . ' 23:59:59');
        } else {
            $expire_time = 0;
        }

        try {
            $data = [
                'title' => $title,
                'phone' => $phone,
                'password' => $password,
                'expire_time' => $expire_time,
                'remark' => $remark
            ];
            if ($id) {
                Db::name('site')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['create_time'] = time();
                Db::name('site')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 删除站点 - 软删除
     */
    public function del()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('site')
                ->where('id', $id)
                ->update([
                    'is_delete' => 1
                ]);
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 设置启用状态
     */
    public function setStatus()
    {
        $id = input('id', 0, 'intval');
        $status = input('status', 0, 'intval');
        try {
            Db::name('site')
                ->where('id', $id)
                ->update([
                    'status' => $status
                ]);
            return successJson('', '设置成功');
        } catch (\Exception $e) {
            return errorJson(text('设置失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 获取一键登录token
     */
    public function getLoginToken()
    {
        $id = input('id', 0, 'intval');
        $site = Db::name('site')
            ->where('id', $id)
            ->find();
        if (!$site) {
            return errorJson('站点不存在，请刷新页面重试');
        }
        $token = uniqid() . rand(1000, 9999);
        try {
            Db::name('site')
                ->where('id', $id)
                ->update([
                    'token' => $token
                ]);
            return successJson([
                'token' => $token
            ]);
        } catch (\Exception $e) {
            return errorJson('登录失败：' . $e->getMessage());
        }
    }

    public function getSelectSiteList()
    {
        $list = Db::name('site')
            ->where('is_delete', 0)
            ->field('id,title')
            ->order('id asc')
            ->select()->toArray();

        return successJson($list);
    }
}
