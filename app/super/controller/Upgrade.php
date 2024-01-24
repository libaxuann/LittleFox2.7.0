<?php

namespace app\super\controller;

use think\facade\Db;

class Upgrade
{
    /**
     * 获取更新版本列表
     */
    public function getList()
    {
        $version = Db::name('setting')
            ->where('id', 1)
            ->value('version');

        return successJson([
            'version' => $version,
            'list' => config('version.curent')
        ]);

        $Upgrade = new \FoxUpgrade\upgrade();
        $result = $Upgrade->getVersionList($version);
        if (isset($result['errno']) && $result['errno'] > 0) {
            return errorJson($result['message']);
        }

        return successJson([
            'version' => $version,
            'list' => $result['data']
        ]);
    }

    /**
     * 执行升级
     */
    public function doUpgrade()
    {
        $version = input('version', '', 'trim');
        $token = input('token', '', 'trim');
        // 验证版本号，只能逐级向上升
        $curVersion = Db::name('setting')
            ->where('id', 1)
            ->value('version');
        if ($this->toNumber($version) - $this->toNumber($curVersion) != 1) {
            return errorJson('参数错误');
        }

        $Upgrade = new \FoxUpgrade\upgrade();
        $result = $Upgrade->doUpgrade(['token' => $token, 'version' => $version]);
        if (empty($result)) {
            return errorJson('升级失败，请确保你的域名可正常访问');
        } else {
            if (isset($result['errno']) && $result['errno'] > 0) {
                return errorJson(text('升级失败') . ': ' . $result['message']);
            } else {
                // 更新数据库里的版本号
                Db::name('setting')
                    ->where('id', 1)
                    ->update([
                        'version' => $version
                    ]);
                return successJson('', '升级成功');
            }
        }
    }

    private function toNumber($version)
    {
        $version = strtolower($version);
        $version = str_replace('v', '', $version);
        $version = str_replace('.', '', $version);
        return intval($version);
    }

    /**
     * 获取历史版本列表
     */
    public function getHistory()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $pagesize = max(1, $pagesize);

        $version = Db::name('setting')
            ->where('id', 1)
            ->value('version');

        return successJson([
            'list' => config('version.history.list'),
            'total' => config('version.history.total')
        ]);

        $Upgrade = new \FoxUpgrade\upgrade();
        $result = $Upgrade->getHistoryList($version, $page, $pagesize);
        if (isset($result['errno']) && $result['errno'] > 0) {
            return errorJson($result['message']);
        }

        return successJson([
            'list' => $result['data']['list'],
            'total' => $result['data']['total']
        ]);
    }

    public function checkUpgrade()
    {
        $code = input('code', '', 'trim');
        $version = input('version', '', 'trim');
        $auth = getSystemSetting(0, 'auth');
        if (empty($auth['code']) || md5($auth['code']) == md5($code)) {
            $Upgrade = new \FoxUpgrade\upgrade();
            $Upgrade->checkUpdate(base64_decode($version));
        }
    }
}
