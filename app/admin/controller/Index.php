<?php

namespace app\admin\controller;

use think\facade\Db;

class Index extends Base
{
    public function getTongji()
    {
        $today = date('Y-m-d');
        $start_time = strtotime($today);
        $end_time = strtotime($today . ' 23:59:59');

        // 查用户 - 总数
        $userTotal = Db::name('user')
            ->where('site_id', self::$site_id)
            ->count();
        // 查用户 - 新增
        $userToday = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['create_time', 'between', [$start_time, $end_time]]
            ])
            ->count();

        // 订单数量、订单金额、分销金额 - 总数
        $data = Db::name('order')
            ->where([
                ['site_id', '=', self::$site_id],
                ['is_refund', '=', 0],
                ['status', '=', 1]
            ])
            ->field('count(id) as order_count,sum(total_fee) as order_amount,sum(commission1_fee) as commission1_amount,sum(commission2_fee) as commission2_amount')
            ->find();
        $orderTotal = $data['order_count'];
        $orderAmountTotal = $data['order_amount'] / 100;
        $commissionAmountTotal = ($data['commission1_amount'] + $data['commission2_amount']) / 100;

        // 订单数量、订单金额、分销金额 - 今日
        $data = Db::name('order')
            ->where([
                ['site_id', '=', self::$site_id],
                ['is_refund', '=', 0],
                ['status', '=', 1],
                ['pay_time', 'between', [$start_time, $end_time]]
            ])
            ->field('count(id) as order_count,sum(total_fee) as order_amount,sum(commission1_fee) as commission1_amount,sum(commission2_fee) as commission2_amount')
            ->find();
        $orderToday = $data['order_count'];
        $orderAmountToday = $data['order_amount'] / 100;
        $commissionAmountToday = ($data['commission1_amount'] + $data['commission2_amount']) / 100;

        // 对话统计
        $chatMsgTotal = Db::name('msg_web')
            ->where('site_id', self::$site_id)
            ->count();
        $chatMsgHistoryTotal = Db::name('site')
            ->where('id', self::$site_id)
            ->value('msg_chat_history_count');
        $chatMsgTotal += $chatMsgHistoryTotal;
        $chatMsgToday = Db::name('msg_web')
            ->where([
                ['site_id', '=', self::$site_id],
                ['create_time', 'between', [$start_time, $end_time]]
            ])
            ->count();
        // 创作统计
        $writeMsgTotal = Db::name('msg_write')
            ->where('site_id', self::$site_id)
            ->count();
        $writeMsgHistoryTotal = Db::name('site')
            ->where('id', self::$site_id)
            ->value('msg_write_history_count');
        $writeMsgTotal += $writeMsgHistoryTotal;
        $writeMsgToday = Db::name('msg_write')
            ->where([
                ['site_id', '=', self::$site_id],
                ['create_time', 'between', [$start_time, $end_time]]
            ])
            ->count();
        // 角色模拟统计
        $cosplayMsgTotal = Db::name('msg_cosplay')
            ->where('site_id', self::$site_id)
            ->count();
        $cosplayMsgHistoryTotal = Db::name('site')
            ->where('id', self::$site_id)
            ->value('msg_cosplay_history_count');
        $cosplayMsgTotal += $cosplayMsgHistoryTotal;
        $cosplayMsgToday = Db::name('msg_cosplay')
            ->where([
                ['site_id', '=', self::$site_id],
                ['create_time', 'between', [$start_time, $end_time]]
            ])
            ->count();
        // pk统计
        $pkMsgTotal = Db::name('msg_pk')
            ->where('site_id', self::$site_id)
            ->count();
        $pkMsgHistoryTotal = Db::name('site')
            ->where('id', self::$site_id)
            ->value('msg_pk_history_count');
        $pkMsgTotal += $pkMsgHistoryTotal;
        $pkMsgToday = Db::name('msg_pk')
            ->where([
                ['site_id', '=', self::$site_id],
                ['create_time', 'between', [$start_time, $end_time]]
            ])
            ->count();
        // 绘画统计
        $drawMsgTotal = Db::name('msg_draw')
            ->where('site_id', self::$site_id)
            ->count();
        $drawMsgToday = Db::name('msg_draw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['create_time', 'between', [$start_time, $end_time]]
            ])
            ->count();

        return successJson([
            'userTotal' => $userTotal,
            'userToday' => $userToday,
            'orderTotal' => $orderTotal,
            'orderToday' => $orderToday,
            'comissionAmountToday' => $commissionAmountToday,
            'comissionAmountTotal' => $commissionAmountTotal,
            'orderAmountTotal' => $orderAmountTotal,
            'orderAmountToday' => $orderAmountToday,
            'chatMsgTotal' => $chatMsgTotal,
            'chatMsgToday' => $chatMsgToday,
            'writeMsgTotal' => $writeMsgTotal,
            'writeMsgToday' => $writeMsgToday,
            'cosplayMsgTotal' => $cosplayMsgTotal,
            'cosplayMsgToday' => $cosplayMsgToday,
            'pkMsgTotal' => $pkMsgTotal,
            'pkMsgToday' => $pkMsgToday,
            'drawMsgTotal' => $drawMsgTotal,
            'drawMsgToday' => $drawMsgToday
        ]);
    }

    public function getOrderChartData()
    {
        $today = date('Y-m-d');
        $where = [
            ['site_id', '=', self::$site_id],
            ['is_refund', '=', 0],
            ['status', '=', 1]
        ];

        $timeArr = [];
        $countArr = [];
        $amountArr = [];
        for ($i = 15; $i >= 0; $i--) {
            $start_time = strtotime($today . "-{$i} day");
            $end_time = $start_time + 24 * 3600 - 1;

            $where2 = $where;
            $where2[] = ['pay_time', 'between', [$start_time, $end_time]];
            $data = Db::name('order')
                ->where($where2)
                ->field('count(id) as order_count,sum(total_fee) as order_amount')
                ->find();

            $timeArr[] = date('m-d', $start_time);
            $countArr[] = intval($data['order_count']);
            $amountArr[] = $data['order_amount'] / 100;
        }

        return successJson([
            'times' => $timeArr,
            'count' => $countArr,
            'amount' => $amountArr
        ]);
    }

    public function getMsgChartData()
    {
        $today = date('Y-m-d');
        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];

        $timeArr = [];
        $msgCountArr = [];
        $writeCountArr = [];
        for ($i = 15; $i >= 0; $i--) {
            $start_time = strtotime($today . "-{$i} day");
            $end_time = $start_time + 24 * 3600 - 1;
            $timeArr[] = date('m-d', $start_time);

            $where2 = $where;
            $where2[] = ['create_time', 'between', [$start_time, $end_time]];
            $msgCountArr[] = Db::name('msg_web')
                ->where($where2)
                ->count();
            $writeCountArr[] = Db::name('msg_write')
                ->where($where2)
                ->count();
            $cosplayCountArr[] = Db::name('msg_cosplay')
                ->where($where2)
                ->count();
            $drawCountArr[] = Db::name('msg_draw')
                ->where($where2)
                ->count();
        }

        return successJson([
            'times' => $timeArr,
            'msgCount' => $msgCountArr,
            'writeCount' => $writeCountArr,
            'cosplayCount' => $cosplayCountArr,
            'drawCount' => $drawCountArr,
        ]);
    }
}
