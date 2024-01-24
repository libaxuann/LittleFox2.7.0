<?php

namespace app\web\controller;

use think\facade\Db;

class Task extends Base
{
    /**
     * 获取任务配置
     */
    public function getTasks()
    {
        $platform = input('platform', 'wxapp', 'trim');
        $share = getSystemSetting(self::$site_id, 'reward_share');
        $invite = getSystemSetting(self::$site_id, 'reward_invite');
        $ad = getSystemSetting(self::$site_id, 'reward_ad');

        $tasks = [];
        $today = strtotime(date('Y-m-d'));
        /*if (!empty($share['is_open']) && !empty($share['max']) && !empty($share['num'])) {
            if ($platform == 'wxapp') {
                // 获取今日已分享次数
                $count = Db::name('reward_share')
                    ->where([
                        ['user_id', '=', self::$user['id']],
                        ['create_time', '>', $today]
                    ])
                    ->count();
                $share['count'] = intval($count);
                $tasks['share'] = $share;
            }
        }*/
        if (!empty($invite['is_open']) && !empty($invite['max']) && !empty($invite['num'])) {
            // 获取今日已邀请人数
            $count = Db::name('reward_invite')
                ->where([
                    ['user_id', '=', self::$user['id']],
                    ['create_time', '>', $today]
                ])
                ->count();
            $invite['count'] = intval($count);
            $tasks['invite'] = $invite;
        }
        if (!empty($ad['is_open']) && !empty($ad['max']) && !empty($ad['num']) && !empty($ad['ad_unit_id'])) {
            // 获取今日已观看广告次数
            if ($platform == 'wxapp') {
                $count = Db::name('reward_ad')
                    ->where([
                        ['user_id', '=', self::$user['id']],
                        ['create_time', '>', $today]
                    ])
                    ->count();
                $ad['count'] = intval($count);
                $tasks['ad'] = $ad;
            }
        }

        $tasks = count($tasks) > 0 ? $tasks : null;

        return successJson($tasks);
    }

    /**
     * 观看广告视频
     */
    public function doPlayAd()
    {
        $ad_unit_id = input('ad_unit_id', '', 'trim');
        if (!$ad_unit_id) {
            return errorJson('参数错误');
        }
        $today = strtotime(date('Y-m-d'));
        $count = Db::name('reward_ad')
            ->where([
                ['user_id', '=', self::$user['id']],
                ['create_time', '>', $today]
            ])
            ->count();

        Db::startTrans();
        try {
            $setting = getSystemSetting(self::$site_id, 'reward_ad');
            if (!empty($setting['is_open']) && !empty($setting['max']) && $count < intval($setting['max']) && !empty($setting['num']) && !empty($setting['ad_unit_id'])) {
                if ($setting['ad_unit_id'] != $ad_unit_id) {
                    return errorJson('参数出错，请刷新页面重试！');
                }
                $reward_num = intval($setting['num']);
                changeUserBalance(self::$user['id'], $reward_num, '观看广告奖励');
            } else {
                $reward_num = 0;
            }
            Db::name('reward_ad')
                ->insert([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'reward_num' => $reward_num,
                    'ad_unit_id' => $ad_unit_id,
                    'create_time' => time()
                ]);
            Db::commit();
            if ($reward_num > 0) {
                $msg = '完成任务，余额 +' . $reward_num;
            } else {
                $msg = '今日已达观看上限，无法获得奖励';
            }
            return successJson('', $msg);
        } catch (\Exception $e) {
            Db::rollback();
            return errorJson(text('任务同步失败') . ': ' . $e->getMessage());
        }
    }
}
