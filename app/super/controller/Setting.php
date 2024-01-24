<?php

namespace app\super\controller;

use think\facade\Db;

class Setting extends Base
{
    public function getSetting()
    {
        $name = input('name', 'system', 'trim');

        $setting = getSystemSetting(0, $name);

        if (!$setting || count($setting) == 0) {
            if ($name == 'system') {
                $setting = [
                    'system_title' => '',
                    'system_logo' => '',
                    'system_icp' => ''
                ];
            }
            if ($name == 'filter') {
                $setting = [
                    'handle_type' => 1
                ];
            }
            if ($name == 'api') {
                $setting = [
                    'outstream' => 'nostream',
                    'channel' => 'gpt',
                    'host' => '',
                    'key' => '',
                    'agent_host' => ''
                ];
            }
            if ($name == 'storage') {
                $setting = [
                    'engine' => 'local'
                ];
            }
        }

        return successJson($setting);
    }

    public function setSetting()
    {
        $name = input('name', '', 'trim');
        $data = input('data', '', 'trim');
        $res = setSystemSetting(0, $name, $data);
        if ($res) {
            return successJson('', '保存成功');
        } else {
            return errorJson('保存失败，请重试！');
        }
    }
}
