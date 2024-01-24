<?php

namespace app\web\controller;

use think\facade\Db;
class Cosplay extends Base
{
    public function getAllRoles()
    {
        $dataList = Db::name('cosplay_type')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1]
            ])
            ->order('weight desc, id asc')
            ->field('id,title')
            ->select()->each(function ($item) {
                $item['roles'] = Db::name('cosplay_role')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['type_id', '=', $item['id']],
                        ['state', '=', 1],
                        ['is_delete', '=', 0]
                    ])
                    ->order('weight desc,usages desc,views desc,id asc')
                    ->field('id,title,thumb,usages,views,fake_usages,fake_views')
                    ->select()->each(function ($item) {
                        $item['views'] = $this->formatNumber($item['views'] + $item['fake_views']);
                        $item['usages'] = $this->formatNumber($item['usages'] + $item['fake_usages']);
                        unset($item['fake_usages'], $item['fake_views']);
                        return $item;
                    })->toArray();
                return $item;
            });

        return successJson($dataList);
    }

    private function formatNumber($num)
    {
        if ($num >= 100000) {
            $num = intval($num / 10000) . 'w';
        } elseif ($num >= 10000) {
            $num = intval($num / 1000) / 10 . 'w';
        } elseif ($num >= 1000) {
            $num = intval($num / 100) / 10 . 'k';
        }
        return $num;
    }

    public function getRole()
    {
        $role_id = input('role_id', '', 'intval');
        $info = Db::name('cosplay_role')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $role_id],
                ['state', '=', 1],
                ['is_delete', '=', 0]
            ])
            ->field('id,title,thumb,hint,welcome,tips')
            ->find();
        if (!$info) {
            return errorJson('未找到此身份模型');
        }
        // 点击量+1
        Db::name('cosplay_role')
            ->where('id', $info['id'])
            ->inc('views', 1)
            ->update();

        return successJson($info);
    }

    /**
     * 消息历史记录
     */
    public function getHistoryMsg()
    {
        $role_id = input('role_id', 0, 'intval');
        $list = Db::name('msg_cosplay')
            ->where([
                ['user_id', '=', self::$user['id']],
                ['role_id', '=', $role_id],
                ['is_delete', '=', 0]
            ])
            ->field('message,response')
            ->order('id desc')
            ->limit(10)
            ->select()->toArray();
        $msgList = [];
        $list = array_reverse($list);
        foreach ($list as $v) {
            $msgList[] = [
                'user' => '我',
                'message' => $v['message']
            ];
            $msgList[] = [
                'user' => 'AI',
                'message' => $v['response']
            ];
        }
        if (empty($msgList)) {
            $role = Db::name('cosplay_role')
                ->where([
                    ['id', '=', $role_id],
                    ['is_delete', '=', 0]
                ])
                ->field('hint,welcome')
                ->find();
            if ($role) {
                if (!empty($role['welcome'])) {
                    $msgList[] = [
                        'user' => 'AI',
                        'message' => formatMsg($role['welcome'])
                    ];
                } else {
                    $msgList[] = [
                        'user' => 'AI',
                        'message' => formatMsg(text('提示') . ': ' . $role['hint'])
                    ];
                }
            }
        }

        return successJson($msgList);
    }
}
