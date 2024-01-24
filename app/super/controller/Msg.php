<?php

namespace app\super\controller;

use think\facade\Db;

class Msg extends Base
{

    private static $pageStartTime = 0;

    public function getMsgList()
    {
        $type = input('type', 'chat', 'trim');
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $date = input('date', []);
        $user_id = input('user_id', 0, 'intval');
        $keyword = input('keyword', '', 'trim');
        $is_history = input('is_history', 0, 'intval');
        $site_id = input('site_id', 0, 'intval');

        $where = [
            ['is_delete', '=', 0]
        ];
        if ($site_id) {
            $where[] = ['site_id', '=', $site_id];
        }
        if ($user_id) {
            $where[] = ['user_id', '=', $user_id];
        }
        if ($keyword) {
            $where[] = ['message', 'like', '%' . $keyword, '%'];
        }
        if (!empty($date)) {
            $start_time = strtotime($date[0]);
            $end_time = strtotime($date[1]);
            $where[] = ['create_time', 'between', [$start_time, $end_time]];
        }
        if ($type == 'chat') {
            $dbName = 'msg_web';
        } elseif ($type == 'write') {
            $dbName = 'msg_write';
        } elseif ($type == 'cosplay') {
            $dbName = 'msg_cosplay';
        } elseif ($type == 'pk') {
            $dbName = 'msg_pk';
        } else {
            return errorJson('参数错误');
        }
        if ($is_history) {
            $dbName .= '_history';
        }

        $list = Db::name($dbName)
            ->where($where)
            ->order('id desc')
            ->page($page, $pagesize)
            ->select()->each(function ($item) use ($type){
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                $item['message'] = formatMsg($item['message']);
                $item['message_input'] = formatMsg($item['message_input']);
                if ($item['message'] == $item['message_input']) {
                    unset($item['message_input']);
                }
                if ($type == 'pk') {
                    $item['channel_a'] = getAIName($item['channel_a']);
                    $item['response_a'] = formatMsg($item['response_a']);
                    $item['channel_b'] = getAIName($item['channel_b']);
                    $item['response_b'] = formatMsg($item['response_b']);
                } else {
                    $item['response'] = formatMsg($item['response']);

                    if ($type == 'write') {
                        $item['topic_title'] = Db::name('write_topic')
                            ->where('id', $item['topic_id'])
                            ->value('title');
                        $item['prompt_title'] = Db::name('write_prompts')
                            ->where('id', $item['prompt_id'])
                            ->value('title');
                    } elseif ($type == 'cosplay') {
                        $item['topic_title'] = Db::name('cosplay_type')
                            ->where('id', $item['type_id'])
                            ->value('title');
                        $item['prompt_title'] = Db::name('cosplay_role')
                            ->where('id', $item['role_id'])
                            ->value('title');
                    }

                    switch ($item['channel']) {
                        case 'openai':
                            $item['channel'] = 'openai3';
                            break;
                        case 'baidu':
                            $item['channel'] = 'wenxin';
                            break;
                    }
                    if ($item['channel']) {
                        $item['channel'] = getAIName($item['channel']);
                    } else {
                        $item['channel'] = '查看回复';
                    }
                }

                return $item;
            });
        $count = Db::name($dbName)
            ->where($where)
            ->count();

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    /**
     * 统计
     */
    public function getMsgTongji()
    {
        $site_id = input('site_id', 0, 'intval');
        $date = input('date', []);
        $user_id = input('user_id', 0, 'intval');
        $keyword = input('keyword', '', 'trim');
        $type = input('type', '', 'trim');
        $is_history = input('is_history', 0, 'intval');

        $where = [
            ['is_delete', '=', 0]
        ];
        if ($site_id) {
            $where[] = ['site_id', '=', $site_id];
        }
        if ($user_id) {
            $where[] = ['user_id', '=', $user_id];
        }
        if ($keyword) {
            $where[] = ['message_input|response_input', 'like', '%' . $keyword, '%'];
        }
        if (!empty($date)) {
            $start_time = strtotime($date[0]);
            $end_time = strtotime($date[1]);
            $where[] = ['create_time', 'between', [$start_time, $end_time]];
        }

        if ($type == 'chat') {
            $dbName = 'msg_web';
        } elseif ($type == 'write') {
            $dbName = 'msg_write';
        } elseif ($type == 'cosplay') {
            $dbName = 'msg_cosplay';
        } elseif ($type == 'pk') {
            $dbName = 'msg_pk';
        } else {
            return errorJson('参数错误');
        }
        if ($is_history) {
            $dbName .= '_history';
        }
        if ($type == 'pk') {
            $data = Db::name($dbName)
                ->where($where)
                ->field('count(id) as msg_count,sum(total_tokens_a) + sum(total_tokens_b) as msg_tokens')
                ->find();
        } else {
            $data = Db::name($dbName)
                ->where($where)
                ->field('count(id) as msg_count,sum(total_tokens) as msg_tokens')
                ->find();
        }

        return successJson([
            'msgCount' => intval($data['msg_count']),
            'msgTokens' => intval($data['msg_tokens'])
        ]);
    }

    public function delMsg()
    {
        $type = input('type', 'chat', 'trim');
        $id = input('id', 0, 'intval');
        $is_history = input('is_history', 0, 'intval');

        if ($type == 'chat') {
            $dbName = 'msg_web';
        } elseif ($type == 'write') {
            $dbName = 'msg_write';
        } elseif ($type == 'cosplay') {
            $dbName = 'msg_cosplay';
        } elseif ($type == 'pk') {
            $dbName = 'msg_pk';
        } else {
            return errorJson('参数错误');
        }
        if ($is_history) {
            $dbName .= '_history';
        }
        try {
            Db::name($dbName)
                ->where('id', $id)
                ->update([
                    'is_delete' => 1
                ]);
            return successJson('', '已移入回收站');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 真正删除
     */
    public function delMsgReal()
    {
        $type = input('type', 'chat', 'trim');
        $id = input('id', 0, 'intval');
        $is_history = input('is_history', 0, 'intval');

        if ($type == 'chat') {
            $dbName = 'msg_web';
        } elseif ($type == 'write') {
            $dbName = 'msg_write';
        } elseif ($type == 'cosplay') {
            $dbName = 'msg_cosplay';
        } elseif ($type == 'pk') {
            $dbName = 'msg_pk';
        } else {
            return errorJson('参数错误');
        }
        if ($is_history) {
            $dbName .= '_history';
        }
        try {
            Db::name($dbName)
                ->where([
                    ['id', '=', $id],
                    ['is_delete', '=', 1], // 只能从回收站里强删
                ])
                ->delete();
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    public function getMoveCount()
    {
        $endTime = strtotime('-1 months');

        $chatMoveCount = Db::name('msg_web')
            ->where('create_time', '<', $endTime)
            ->count();
        $chatLeaveCount = Db::name('msg_web')
            ->where('create_time', '>=', $endTime)
            ->count();
        $chatHistoryCount = Db::name('msg_web_history')
            ->count();
        $writeMoveCount = Db::name('msg_write')
            ->where('create_time', '<', $endTime)
            ->count();
        $writeLeaveCount = Db::name('msg_write')
            ->where('create_time', '>=', $endTime)
            ->count();
        $writeHistoryCount = Db::name('msg_write_history')
            ->count();
        $cosplayMoveCount = Db::name('msg_cosplay')
            ->where('create_time', '<', $endTime)
            ->count();
        $cosplayLeaveCount = Db::name('msg_cosplay')
            ->where('create_time', '>=', $endTime)
            ->count();
        $cosplayHistoryCount = Db::name('msg_cosplay_history')
            ->count();
        $pkMoveCount = Db::name('msg_pk')
            ->where('create_time', '<', $endTime)
            ->count();
        $pkLeaveCount = Db::name('msg_pk')
            ->where('create_time', '>=', $endTime)
            ->count();
        $pkHistoryCount = Db::name('msg_pk_history')
            ->count();

        // 上次归档时间
        return successJson([
            'moveCount' => $chatMoveCount + $writeMoveCount + $cosplayMoveCount + $pkMoveCount,
            'leaveCount' => $chatLeaveCount + $writeLeaveCount + $cosplayLeaveCount + $pkLeaveCount,
            'historyCount' => $chatHistoryCount + $writeHistoryCount + $cosplayHistoryCount + $pkHistoryCount
        ]);
    }

    public function moveData()
    {
        self::$pageStartTime = microtime(true);
        $limitRuntime = 10;
        $endTime = strtotime('-1 months');
        // 对话记录
        while (1) {
            $list = Db::name('msg_web')
                ->where('create_time', '<', $endTime)
                ->order('id asc')
                ->limit(100)
                ->select()->toArray();
            if (empty($list)) {
                break;
            }
            foreach ($list as $v) {
                // 判断有没有执行超时
                $runtime = $this->getRunTime();
                if ($runtime > $limitRuntime) {
                    return successJson([
                        'continue' => 1
                    ]);
                }

                $rs = Db::name('msg_web_history')
                    ->insert($v);
                if ($rs) {
                    Db::name('msg_web')
                        ->where('id', $v['id'])
                        ->delete();
                }
            }
        }
        // 创作记录
        while(1) {
            $list = Db::name('msg_write')
                ->where('create_time', '<', $endTime)
                ->order('id asc')
                ->limit(100)
                ->select()->toArray();
            if (empty($list)) {
                break;
            }
            foreach ($list as $v) {
                // 判断有没有执行超时
                $runtime = $this->getRunTime();
                if ($runtime > $limitRuntime) {
                    return successJson([
                        'continue' => 1
                    ]);
                }

                $rs = Db::name('msg_write_history')
                    ->insert($v);
                if ($rs) {
                    Db::name('msg_write')
                        ->where('id', $v['id'])
                        ->delete();
                }
            }
        }
        // 角色模拟记录
        while(1) {
            $list = Db::name('msg_cosplay')
                ->where('create_time', '<', $endTime)
                ->order('id asc')
                ->limit(100)
                ->select()->toArray();
            if (empty($list)) {
                break;
            }
            foreach ($list as $v) {
                // 判断有没有执行超时
                $runtime = $this->getRunTime();
                if ($runtime > $limitRuntime) {
                    return successJson([
                        'continue' => 1
                    ]);
                }

                $rs = Db::name('msg_cosplay_history')
                    ->insert($v);
                if ($rs) {
                    Db::name('msg_cosplay')
                        ->where('id', $v['id'])
                        ->delete();
                }
            }
        }
        // pk记录
        while(1) {
            $list = Db::name('msg_pk')
                ->where('create_time', '<', $endTime)
                ->order('id asc')
                ->limit(100)
                ->select()->toArray();
            if (empty($list)) {
                break;
            }
            foreach ($list as $v) {
                // 判断有没有执行超时
                $runtime = $this->getRunTime();
                if ($runtime > $limitRuntime) {
                    return successJson([
                        'continue' => 1
                    ]);
                }

                $rs = Db::name('msg_pk_history')
                    ->insert($v);
                if ($rs) {
                    Db::name('msg_pk')
                        ->where('id', $v['id'])
                        ->delete();
                }
            }
        }

        return successJson([
            'continue' => 0
        ], '执行完毕');
    }

    /**
     * 更新每个站点的数据量统计，以提升后台数据统计速度
     */
    public function updateSiteCount()
    {
        $allSite = Db::name('site')->field('id')->select()->toArray();
        foreach ($allSite as $site) {
            $msg_chat_history_count = Db::name('msg_web_history')->where('site_id', $site['id'])->count();
            $msg_write_history_count = Db::name('msg_write_history')->where('site_id', $site['id'])->count();
            $msg_cosplay_history_count = Db::name('msg_cosplay_history')->where('site_id', $site['id'])->count();
            $msg_pk_history_count = Db::name('msg_pk_history')->where('site_id', $site['id'])->count();
            Db::name('site')
                ->where('id', $site['id'])
                ->update([
                    'msg_chat_history_count' => $msg_chat_history_count,
                    'msg_write_history_count' => $msg_write_history_count,
                    'msg_cosplay_history_count' => $msg_cosplay_history_count,
                    'msg_pk_history_count' => $msg_pk_history_count
                ]);
        }
        return successJson('', '执行完毕');
    }

    private function getRunTime()
    {
        $etime = microtime(true);
        $total = $etime - self::$pageStartTime;
        return round($total, 4);
    }
}
