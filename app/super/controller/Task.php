<?php

namespace app\super\controller;

use think\facade\Db;
use think\facade\Cache;

class Task
{
    public function moveData()
    {
        $now = time();
        $last_move_time = $this->getLastMoveTime();

        // 判断并记录上次归档时间
        if ($now - $last_move_time < 600) {
            return errorJson('已有后台任务正在执行，请稍后再试（每次间隔不小于10分钟）');
        }
        $this->setLastMoveTime($now);

        // 发起异步网络请求
        $token = uniqid() . rand(100, 999);
        $url = 'https://' . $_SERVER['HTTP_HOST'] . '/super.php/task/moveData?token=' . $token;
        Cache::set('task_token', $token);
        $this->httpRequest($url);
        return successJson('', '任务已在后台开始执行');
    }



    private function httpRequest($url)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_TIMEOUT_MS, 10000);
        curl_exec($ch);
        curl_close($ch);
    }
}
