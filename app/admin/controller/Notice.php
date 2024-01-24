<?php

namespace app\admin\controller;

use think\facade\Db;

class Notice extends Base
{
    public function getList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        try {
            $where = [
                'site_id' => self::$site_id
            ];
            $list = Db::name('notice')
                ->where($where)
                ->order('id desc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    $now = time();
                    if ($item['start_time'] > $now) {
                        $item['status'] = 'wait';
                    } elseif ($item['end_time'] > $now) {
                        $item['status'] = 'active';
                    } else {
                        $item['status'] = 'expired';
                    }

                    if ($item['start_time']) {
                        $item['start_time'] = date('Y-m-d H:i:s', $item['start_time']);
                    }
                    if ($item['end_time']) {
                        $item['end_time'] = date('Y-m-d H:i:s', $item['end_time']);
                    }
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    return $item;
                });
            $count = Db::name('notice')
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
     * 取单个文章
     */
    public function getArticle()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('notice')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->find();
            $info['start_time'] = date('Y-m-d H:i:s', $info['start_time']);
            $info['end_time'] = date('Y-m-d H:i:s', $info['end_time']);
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveArticle()
    {
        $id = input('id', 0, 'intval');
        $platform = input('platform', '', 'trim');
        $type = input('type', '', 'trim');
        $content = input('content', '', 'trim');
        $start_time = input('start_time', '', 'trim');
        $end_time = input('end_time', '', 'trim');
        $remark = input('remark', '', 'trim');

        try {
            $data = [
                'platform' => $platform,
                'type' => $type,
                'content' => $content,
                'start_time' => strtotime($start_time),
                'end_time' => strtotime($end_time),
                'remark' => $remark
            ];
            if ($id) {
                Db::name('notice')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('notice')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 删除文章
     */
    public function delArticle()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('notice')
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
}
