<?php

namespace app\admin\controller;

use think\facade\Db;

class Batch extends Base
{
    public function getBatchList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $date = input('date', []);
        $user_id = input('user_id', 0, 'intval');
        $keyword = input('keyword', '', 'trim');

        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];
        if ($user_id) {
            $where[] = ['user_id', '=', $user_id];
        }
        if ($keyword) {
            $where[] = ['prompt', 'like', '%' . $keyword . '%'];
        }
        if (!empty($date)) {
            $start_time = strtotime($date[0]);
            $end_time = strtotime($date[1]);
            $where[] = ['create_time', 'between', [$start_time, $end_time]];
        }

        $list = Db::name('batch')
            ->where($where)
            ->order('id desc')
            ->page($page, $pagesize)
            ->select()->each(function ($item) {
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                $item['ai'] = getAIName($item['ai']);
                return $item;
            });

        $count = Db::name('batch')
            ->where($where)
            ->count();

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    public function getTaskList()
    {
        $batch_id = input('id','','trim');
        $where = [
            ['site_id', '=', self::$site_id],
            ['batch_id', '=', $batch_id],
            ['is_delete', '=', 0]
        ];
        $list = Db::name('batch_task')
            ->where($where)
            ->order('id asc')
            ->select()->each(function ($item) {
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                $item['response'] = formatMsg($item['response']);
                return $item;
            });
        return successJson(['list' => $list]);
    }
}
