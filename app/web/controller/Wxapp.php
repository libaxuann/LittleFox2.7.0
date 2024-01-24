<?php

namespace app\web\controller;

use think\facade\Db;
use think\facade\Request;

class Wxapp
{
    /**
     * 微信小程序静默登录获取openid
     */
    public function login()
    {
        $code = input('code', '', 'trim');
        $site_id = input('site_id', 1, 'intval');
        $sitecode = Db::name('site')
            ->where('id', $site_id)
            ->value('sitecode');
        $setting = getSystemSetting($site_id, 'wxapp');
        $Wxapp = new \Weixin\Wxapp($setting['appid'], $setting['appsecret']);
        $oauth = $Wxapp->getOauthInfo($code);
        if (empty($oauth['openid'])) {
            $message = text('登录失败');
            if (isset($oauth['errmsg'])) {
                $message .= '（' . $oauth['errmsg'] . '）';
            }
            return errorJson($message);
        }
        $openid = $oauth['openid'];


        return successJson([
            'sitecode' => $sitecode,
            'openid' => $openid
        ]);
    }

    /**
     * 微信授权登录
     */
    public function wechatLogin()
    {
        $site_id = input('site_id', 0, 'intval');
        $code = input('code', '', 'trim');
        $openid_wxapp = input('openid', '', 'trim');
        $tuid = input('tuid', 0, 'intval');
        $wxmpConfig = getSystemSetting($site_id, 'wxmp');
        $config = [
            'app_id' => $wxmpConfig['appid'] ?? '',
            'secret' => $wxmpConfig['appsecret'] ?? '',
            'response_type' => 'array',
            'debug' => false
        ];
        $app = \EasyWeChat\Factory::officialAccount($config);
        $oauth = $app->oauth;
        if (!$code) {
            if (!isset($wxmpConfig['appid'])) {
                return view('wxapp/wechatLogin', [
                    'error' => text('请先配置公众号参数')
                ]);
            }
            $callback = Request::url(true);
            $response = $oauth->scopes(['snsapi_userinfo'])
                ->redirect($callback);
            $response->send();
            exit;
        } else {
            try {
                $user = $oauth->user()->toArray();
                if (empty($user)) {
                    return view('wxapp/wechatLogin', [
                        'error' => text('页面已过期，请重新打开')
                    ]);
                }
                $openid_mp = $user['id'];
                $avatar = $user['avatar'];
                $nickname = $user['nickname'];

                // 登录成功
                $user = Db::name('user')
                    ->where([
                        ['site_id', '=', $site_id],
                        ['openid_mp', '=', $openid_mp]
                    ])
                    ->find();
                if ($user) {
                    if (!$user['openid'] || $user['openid'] != $openid_wxapp) {
                        // 将小程序openid绑定到微信账号
                        Db::name('user')
                            ->where([
                                ['site_id', '=', $site_id],
                                ['id', '=', $user['id']]
                            ])
                            ->update([
                                'openid' => $openid_wxapp
                            ]);
                    }
                    $user_id = $user['id'];
                } else {
                    $tuser = Db::name('user')
                        ->where([
                            ['site_id', '=', $site_id],
                            ['id', '=', $tuid]
                        ])
                        ->find();
                    if (!$tuser) {
                        $tuid = 0;
                    }
                    $user_id = Db::name('user')
                        ->insertGetId([
                            'site_id' => $site_id,
                            'openid' => $openid_wxapp,
                            'openid_mp' => $openid_mp,
                            'avatar' => $avatar,
                            'nickname' => $nickname,
                            'tuid' => $tuid,
                            'create_time' => time()
                        ]);
                    // 送免费条数
                    giveFreeNum($site_id, $user_id);
                    // 送邀请人次数
                    if ($tuid) {
                        $today = strtotime(date('Y-m-d'));
                        $count = Db::name('user')
                            ->where([
                                ['tuid', '=', $tuid],
                                ['create_time', '>', $today]
                            ])
                            ->count();
                        $setting = getSystemSetting($site_id, 'reward_invite');
                        if (!empty($setting['is_open']) && !empty($setting['max']) && $count < intval($setting['max']) && !empty($setting['num'])) {
                            $reward_num = intval($setting['num']);
                            changeUserBalance($tuid, $reward_num, '邀请朋友奖励');
                            Db::name('reward_invite')
                                ->insert([
                                    'site_id' => $site_id,
                                    'user_id' => $tuid,
                                    'way' => 'wxapp',
                                    'newuser_id' => $user_id,
                                    'reward_num' => $reward_num,
                                    'create_time' => time()
                                ]);
                        }
                    }
                }

                // 登录成功
                $user = Db::name('user')
                    ->where([
                        ['site_id', '=', $site_id],
                        ['id', '=', $user_id]
                    ])
                    ->find();
                $sitecode = Db::name('site')
                    ->where('id', $site_id)
                    ->value('sitecode');

                $token = uniqid() . $user['id'];
                session_id($token);
                session_start();
                $_SESSION['user'] = json_encode($user);
                $_SESSION['sitecode'] = $sitecode;

                $apis = [
                    'checkJsApi',
                    'miniProgram'
                ];
                $jssdkConfig = $app->jssdk->buildConfig($apis, false, false, false);
                return view('wxapp/wechatLogin', [
                    'user_id' => $user_id,
                    'jssdk' => $jssdkConfig,
                    'token' => $token
                ]);
            } catch (\Exception $e) {
                return view('wxapp/wechatLogin', [
                    'error' => $e->getMessage()
                ]);
            }
        }
    }

    /**
     * 获取小程序配置参数
     */
    public function getSetting()
    {
        $lastVersion = 'v1.3.9'; // 此版本号要与前端最新版本号一致
        $site_id = input('site_id', 1, 'intval');
        $version = input('version', '', '');
        $wxapp = getSystemSetting($site_id, 'wxapp');
        $page_title = $wxapp['page_title'] ?? 'AI创作助手';
        $welcome = $wxapp['welcome'] ?? '你好，我是AI创作助手！你现在可以向我提问了！';
        $share_title = $wxapp['share_title'] ?? '';
        $share_image = $wxapp['share_image'] ?? '';
        $is_check = empty($wxapp['is_check']) ? 0 : 1;
        $is_check = $version == $lastVersion ? $is_check : 0;
        $is_ios_pay = empty($wxapp['is_ios_pay']) ? 0 : 1;
        $apiSetting = getSystemSetting(0, 'api');
        $outtype = $apiSetting['outtype'] ?? 'nostream';
        $wxappIndex = getSystemSetting($site_id, 'wxapp_index');
        $indexType = $wxappIndex['type'] ?? 'chat';

        // 绘画 - 功能开关
        $drawSetting = getSystemSetting($site_id, 'draw');
        $drawIsOpen = isset($drawSetting['is_open']) ? intval($drawSetting['is_open']) : 1;
        // 语音开关
        $speechSetting = getSystemSetting($site_id, 'speech');
        $speechIsOpen = isset($speechSetting['is_open']) ? intval($speechSetting['is_open']) : 0;

        $loginSetting = getSystemSetting($site_id, 'login');
        $login_wechat = isset($loginSetting['login_wechat']) ? $loginSetting['login_wechat'] : 0;
        $login_phone = isset($loginSetting['login_phone']) ? $loginSetting['login_phone'] : 0;
        if (!$login_wechat && !$login_phone) {
            $login_wechat = 1;
        }

        $chatIsOpen = 1;
        $writeIsOpen = 1;
        $cosplayIsOpen = 1;
        $userIsOpen = 1;

        // gpt4配置
        $ai4Setting = getSystemSetting($site_id, 'gpt4');
        $ai4Channel = [];
        $hasModel4 = 0;
        $model4Name = '';
        if (!empty($ai4Setting['is_open'])) {
            $hasModel4 = 1;
            $model4Name = '高级版';
            $ai4Channel = isset($ai4Setting['channel']) ? $ai4Setting['channel'] : [];
        }
        // 普通ai配置
        $aiSetting = getSystemSetting($site_id, 'chatgpt');
        $aiChannel = isset($aiSetting['channel']) ? $aiSetting['channel'] : [];
        $aiChannel = array_merge($aiChannel, $ai4Channel);
        // 汇总成最终AI列表，显示到前端
        $aiList = [];
        foreach ($aiChannel as $aiName) {
            $ai = getAiSetting($site_id, $aiName);
            if (!empty($ai)) {
                $aiList[] = [
                    'name' => $aiName,
                    'alias' => $ai['alias'] ?? $aiName
                ];
            }
        }

        return successJson([
            'page_title' => $page_title,
            'welcome' => $welcome,
            'share_title' => $share_title,
            'share_image' => $share_image,
            'is_check' => $is_check,
            'is_ios_pay' => $is_ios_pay,
            'outtype' => $outtype,
            'index_type' => $indexType,
            'hasModel4' => $hasModel4,
            'model4Name' => $model4Name,
            'login_wechat' => $login_wechat,
            'login_phone' => $login_phone,
            'tabbar' => [$chatIsOpen, $writeIsOpen, $cosplayIsOpen, $drawIsOpen, $userIsOpen],
            'aiList' => $aiList,
            'speechIsOpen' => $speechIsOpen
        ]);
    }

    /**
     * 获取小程序自定义首页内容
     */
    public function getDiyIndex()
    {
        $site_id = input('site_id', 1, 'intval');
        $wxappIndex = getSystemSetting($site_id, 'wxapp_index');

        return successJson([
            'content' => @json_decode($wxappIndex['content'], true)
        ]);
    }

    /**
     * 获取首页广告配置
     */
    public function getIndexAd()
    {
        $site_id = input('site_id', 0, 'intval');
        $ad = getSystemSetting($site_id, 'ad');
        return successJson($ad);
    }
}
