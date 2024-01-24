<?php

namespace app\admin\controller;

use think\facade\Db;

class Setting extends Base
{
    public function getSetting()
    {
        $name = input('name', 'system', 'trim');

        $setting = getSystemSetting(self::$site_id, $name);

        if (!$setting || count($setting) == 0) {
            if ($name == 'system') {
                $setting = [
                    'system_title' => '',
                    'system_logo' => '',
                    'system_icp' => ''
                ];
            }
            elseif ($name == 'wxapp') {
                $setting = [
                    'title' => '',
                    'qrcode' => '',
                    'appid' => '',
                    'appsecret' => '',
                    'page_title' => '',
                    'welcome' => '',
                    'share_title' => '',
                    'share_image' => '',
                    'is_check' => 0,
                    'is_ios_pay' => 1
                ];
            }
            elseif ($name == 'wxapp_upload') {
                $setting = [
                    'upload_secret' => '',
                    'host' => ''
                ];
            }
            elseif ($name == 'wxapp_index') {
                $setting = [
                    'type' => 'chat',
                    'content' => ''
                ];
            }
            elseif ($name == 'chatgpt') {
                $setting = [
                    'channel' => ['wenxin'],
                    'free_num' => 0,
                    'free_num_draw' => 0,
                    'free_num_gpt4' => 0
                ];
            }
            elseif ($name == 'gpt4') {
                $setting = [
                    'is_open' => 0,
                    'channel' => ['wenxin4']
                ];
            }
            elseif ($name == 'pay') {
                $setting = [
                    'mch_id' => '',
                    'key' => '',
                    'apiclient_cert' => '',
                    'apiclient_key' => ''
                ];
            }
            elseif ($name == 'ad') {
                $setting = [
                    'inter_is_open' => 0,
                    'inter_unit_id' => '',
                    'banner_is_open' => 0,
                    'banner_unit_id' => ''
                ];
            }
            elseif ($name == 'reward_share') {
                $setting = [
                    'is_open' => 0,
                    'num' => '',
                    'max' => ''
                ];
            }
            elseif ($name == 'reward_invite') {
                $setting = [
                    'is_open' => 0,
                    'num' => '',
                    'max' => ''
                ];
            }
            elseif ($name == 'reward_ad') {
                $setting = [
                    'is_open' => 0,
                    'num' => '',
                    'max' => '',
                    'ad_unit_id' => ''
                ];
            }
            elseif ($name == 'about') {
                $setting = [
                    'content' => ''
                ];
            }
            elseif ($name == 'kefu') {
                $setting = [
                    'phone' => '',
                    'email' => '',
                    'wxno' => '',
                    'wx_qrcode' => '',
                    'qun_qrcode' => ''
                ];
            }
            elseif ($name == 'commission') {
                $setting = [
                    'is_open' => 0,
                    'auto_audit' => 0,
                    'deep' => 2,
                    'bili_1' => 0,
                    'bili_2' => 0
                ];
            }
            elseif ($name == 'web') {
                $setting = [
                    'is_open' => 0,
                    'bind_wxapp_user' => 0,
                    'page_title' => '',
                    'copyright' => '',
                    'copyright_link' => '',
                    'keywords' => '',
                    'description' => '',
                    'tongji' => ''
                ];
            }
            elseif ($name == 'h5') {
                $setting = [
                    'page_title' => '',
                    'share_title' => '',
                    'share_desc' => '',
                    'share_image' => ''
                ];
            }
            elseif ($name == 'wxmp') {
                $setting = [
                    'title' => '',
                    'appid' => '',
                    'appsecret' => '',
                    'token' => getNonceStr(32),
                    'aes_key' => getNonceStr(43)
                ];
            }
            elseif ($name == 'chat') {
                $setting = [
                    'prompt_type' => 'system',
                    'prompt' => ''
                ];
            }
            elseif ($name == 'draw') {
                $setting = [
                    'is_open' => 1,
                    'platform' => 'openai',
                    'channel' => 'openai'
                ];
            }
            elseif ($name == 'pk') {
                $setting = [
                    'is_open' => 1
                ];
            }
            elseif ($name == 'batch') {
                $setting = [
                    'is_open' => 1
                ];
            }
            elseif ($name == 'team') {
                $setting = [
                    'is_open' => 1
                ];
            }
            elseif ($name == 'novel') {
                $setting = [
                    'is_open' => 1
                ];
            }
            elseif ($name == 'mind') {
                $setting = [
                    'is_open' => 0,
                    'ai' => ''
                ];
            }
            elseif ($name == 'login') {
                $setting = [
                    'login_wechat' => 1,
                    'login_phone' => 0
                ];
            }
            elseif ($name == 'sms') {
                $setting = [
                    'channel' => '',
                    'aliyun' => [],
                    'tencent' => []
                ];
            }
            elseif ($name == 'translate') {
                $setting = [
                    'is_open' => 0,
                    'channel' => 'baidu'
                ];
            }
            elseif ($name == 'speech') {
                $setting = [
                    'is_open' => 0,
                    'channel' => 'baidu',
                    'baidu_spd' => 5,
                    'baidu_pit' => 5,
                    'baidu_per' => '5118'
                ];
            }
        }

        if ($name == 'wxmp') {
            $setting['server_url'] = 'https://' . $_SERVER['HTTP_HOST'] . '/web.php/wxmp/server/site/' . self::$site_id;
        }

        return successJson($setting);
    }

    public function setSetting()
    {
        $name = input('name', '', 'trim');
        $data = input('data', '', 'trim');
        $res = setSystemSetting(self::$site_id, $name, $data);
        if ($res) {
            if ($name == 'web' && self::$site_id == 1) {
                $data = json_decode($data, true);
                $page_title = $data['page_title'] ?? '';
                $keywords = $data['keywords'] ?? '';
                $description = $data['description'] ?? '';
                $tongji = $data['tongji'] ?? '';
                $this->replaceSEO($page_title, $keywords, $description, $tongji);
            }
            return successJson('', '保存成功');
        } else {
            return errorJson('保存失败，请重试！');
        }
    }

    /**
     * @param $title
     * @param $keywords
     * @param $description
     * 替换seo信息
     */
    private function replaceSEO($title, $keywords, $description, $tongji)
    {
        // 替换index的关键词
        $html = file_get_contents('./index.html');
        $html = str_replace("\n", "", $html);
        // 替换标题
        $html = preg_replace('/(<title>)(.*?)(<\/title>)/i', '${1}' . $title . '${3}', $html);
        // 替换关键词
        $html = preg_replace('/(<meta name="keywords" content=")(.*?)(">)/i', '${1}' . $keywords . '${3}', $html);
        // 替换描述
        $html = preg_replace('/(<meta name="description" content=")(.*?)(">)/i', '${1}' . $description . '${3}', $html);
        file_put_contents('./index.html', $html);

        // 替换web目录的关键词
        $html = file_get_contents('./web/index.html');
        $html = str_replace("\n", "", $html);
        // 替换标题
        $html = preg_replace('/(<title>)(.*?)(<\/title>)/i', '${1}' . $title . '${3}', $html);
        // 替换关键词
        $html = preg_replace('/(<meta name=keywords content=")(.*?)(">)/i', '${1}' . $keywords . '${3}', $html);
        // 替换描述
        $html = preg_replace('/(<meta name=description content=")(.*?)(">)/i', '${1}' . $description . '${3}', $html);
        // 替换统计代码
        $html = preg_replace('/(<\/body>)(.*?)(<\/html>)/i', '${1}' . $tongji . '${3}', $html);
        file_put_contents('./web/index.html', $html);
    }

    /**
     * 获取可选模型
     */
    public function getEngines()
    {
        $diyhost = 'http://154.12.55.160';
        $apikey = Db::name('keys')
            ->where([
                ['type', '=', 'openai3'],
                ['state', '=', 1]
            ])
            ->value('key');
        $SDK = new \ChatGPT\openai($apikey);
        $SDK->setApiHost($diyhost);
        $result = $SDK->getModelList();
        print_r($result);
    }

    /**
     * 获取openai余额
     */
    public function getBalance()
    {
        $apikey = input('apikey', '', 'trim');
        if (empty($apikey)) {
            return errorJson('请输入apikey');
        }
        try {
            $ChatGPT = new \ChatGPT\openai($apikey);
            // 使用自定义接口
            $apiSetting = getSystemSetting(0, 'api');
            if ($apiSetting['channel'] == 'agent' && $apiSetting['agent_host']) {
                $ChatGPT->setApiHost(rtrim($apiSetting['agent_host'], '/'));
            }

            $result = $ChatGPT->getBalance();
            if (!isset($result['total_granted'])) {
                return errorJson('查询余额失败');
            }
            return successJson([
                'total_granted' => $result['total_granted'],
                'total_used' => $result['total_used'],
                'total_available' => $result['total_available']
            ]);
        } catch (\Exception $e) {
            return errorJson('查询余额失败');
        }
    }

    /**
     * 获取灵犀ai余额
     */
    public function getLxaiBalance()
    {
        $apikey = input('apikey', '', 'trim');
        if (empty($apikey)) {
            return errorJson('请输入apikey');
        }
        try {
            $lxaiSDK = new \ChatGPT\lxai($apikey);
            $result = $lxaiSDK->getBalance();
            if (!isset($result['total_granted'])) {
                return errorJson('查询余额失败');
            }
            return successJson([
                'total_granted' => $result['total_granted'],
                'total_used' => $result['total_used'],
                'total_available' => $result['total_available']
            ]);
        } catch (\Exception $e) {
            return errorJson('查询余额失败');
        }
    }

    /**
     * 获取所有皮肤
     */
    public function getSkinList()
    {
        $platform = input('platform', 'web', 'trim');
        $skinList = [];
        if ($platform == 'web') {
            $dir = './static/skin/web/';
            $files = scandir($dir);
            foreach ($files as $v) {
                if ($v == '.' || $v == '..') {
                    continue;
                }
                if (!is_file($v)) {
                    $configFile = $dir . '/' . $v . '/config.json';
                    $config = ['title' => $v];
                    if (file_exists($configFile)) {
                        $config = file_get_contents($configFile);
                        if (!empty($config)) {
                            $config = json_decode($config, true);
                        }
                    }
                    $skinList[] = [
                        'name' => $v,
                        'title' => $config['title'] ?? $v,
                        'thumb' => mediaUrl(ltrim($dir, '.') . '/'. $v . '/thumb.png?r=' . rand(100, 999), true)
                    ];
                }
            }
        }
        return successJson($skinList);
    }
}
