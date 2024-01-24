<?php

namespace app\web\controller;

use think\facade\Cache;
use think\facade\Db;
use think\facade\Request;

class Login
{
    private static $sitecode = '';
    private static $site_id = 1;

    public function __construct()
    {
        $site_id = input('site_id', 0, 'intval');
        if ($site_id) {
            $sitecode = Db::name('site')
                ->where('id', $site_id)
                ->value('sitecode');
        } else {
            $sitecode = Request::header('x-site');
            if (empty($sitecode)) {
                $sitecode = input('sitecode', '', 'trim');
            }
            if ($sitecode) {
                $site_id = Db::name('site')
                    ->where('sitecode', $sitecode)
                    ->value('id');
            } else {
                $site_id = 1;
                // 登录方法才用到sitecode
                $sitecode = Db::name('site')
                    ->where('id', 1)
                    ->value('sitecode');
            }
        }

        self::$sitecode = $sitecode;
        self::$site_id = $site_id;
    }

    public function check()
    {
        $code = input('code', '', 'trim');

        $loginInfo = Db::name('pclogin')
            ->where([
                ['site_id', '=', self::$site_id],
                ['code', '=', $code]
            ])
            ->order('id desc')
            ->find();
        if (!$loginInfo || empty($loginInfo['user_id'])) {
            return successJson([
                'login' => 0
            ]);
        }

        // 用一次就过期
        Db::name('pclogin')
            ->where('id', $loginInfo['id'])
            ->delete();

        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $loginInfo['user_id']]
            ])
            ->find();
        if (!$user) {
            return errorJson('登录失败，请重新扫码');
        }

        // 存入session
        $token = uniqid() . $user['id'];
        session_id($token);
        session_start();
        $_SESSION['user'] = json_encode($user);
        $_SESSION['sitecode'] = self::$sitecode;

        return successJson([
            'login' => 1,
            'token' => $token
        ], '登录成功');
    }

    /**
     * 微信扫码登录
     */
    public function getQrcode()
    {
        try {
            $type = input('type', 'login', 'trim');
            if (!in_array($type, ['login', 'bind'])) {
                return errorJson('参数错误');
            }
            $wxmpSetting = getSystemSetting(self::$site_id, 'wxmp');
            if (!isset($wxmpSetting['appid'])) {
                return errorJson('请先配置公众号参数');
            }
            $config = [
                'app_id' => $wxmpSetting['appid'] ?? '',
                'secret' => $wxmpSetting['appsecret'] ?? '',
                'token' => $wxmpSetting['token'] ?? '',
                'aes_key' => $wxmpSetting['aes_key'] ?? '',
                'response_type' => 'array'
            ];

            $code = $type . '_' . getNonceStr(4) . '' . uniqid() . getNonceStr(4);

            $app = \EasyWeChat\Factory::officialAccount($config);
            $result = $app->qrcode->temporary($code, 600);
            if (isset($result['errcode']) && $result['errcode']) {
                return errorJson($result['errmsg']);
            }
            $qrcode = $app->qrcode->url($result['ticket']);

            /*$qrcode = 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEG8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyY20tTzRvczZjTDAxVW81OHhBY2YAAgTAgshkAwRYAgAA';*/

            return successJson([
                'qrcode' => $qrcode,
                'code' => $code
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }

    }

    /**
     * 图形验证码
     */
    public function getCaptcha()
    {
        try {
            $captcha = \think\captcha\facade\Captcha::create(null, true);
            $image = "data:image/png;base64," . base64_encode($captcha->getData());
            $key = session('captcha.key');
            session_start();
            $token = session_id();
            Cache::set('catpcha_' . $token, $key, 300);
            return successJson([
                'image' => $image,
                'token' => $token
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * 发送短信验证码
     */
    public function sendSms()
    {
        $now = time();
        $type = input('type', '', 'trim');
        $phone = input('phone', '', 'trim');

        // 验证图片验证码
        $verify_code = input('code', '', 'trim');
        $token = input('token', '', 'trim');
        $key = Cache::get('catpcha_' . $token);
        if (!password_verify(mb_strtolower($verify_code, 'UTF-8'), $key)) {
            return errorJson('验证码输入有误');
        }

        $isExist = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['phone', '=', $phone]
            ])
            ->find();
        if ($type == 'reg' && $isExist) {
            return errorJson('手机号已存在，可直接登录');
        } elseif ($type == 'reset' && !$isExist) {
            return errorJson('手机号不存在，请检查');
        }

        try {
            // 发送验证码
            $code = rand(100000, 999999);
            $result = sendSms(self::$site_id, $type, $phone, [
                'code' => $code
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
        if (is_array($result) && $result['errno']) {
            return errorJson($result['message']);
        }
        Db::name('smscode')
            ->insert([
                'site_id' => self::$site_id,
                'type' => $type,
                'phone' => $phone,
                'code' => $code,
                'expire_time' => $now + 300,
                'create_time' => $now
            ]);
        return successJson('', '发送成功');
    }

    /**
     * 账号密码登录
     */
    public function login()
    {
        $authcode = input('authcode', '', 'trim');
        $openid = input('openid', '', 'trim');
        if ($authcode) {
            // 自动登录
            $authcode = substr($authcode, 0, strpos($authcode, '?'));
            $user = Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['authcode', '=', $authcode]
                ])
                ->find();
            if (!$user) {
                return errorJson('自动登录失败');
            }
        } else {
            // 账号密码登录
            $phone = input('phone', '', 'trim');
            $password = input('password', '', 'trim');
            if (empty($password)) {
                return errorJson('请输入密码');
            }
            $user = Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['phone', '=', $phone],
                    ['password', '=', $password]
                ])
                ->find();

            if (!$user) {
                return errorJson('账号或密码错误');
            }
        }

        if ($user['is_delete']) {
            return errorJson('账号已被停用');
        }

        if ($user['is_freeze']) {
            return errorJson('账号已被冻结，请联系客服');
        }

        if ($openid) {
            Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $user['id']]
                ])
                ->update([
                    'openid' => $openid
                ]);
        }

        // 存入session
        $token = uniqid() . $user['id'];
        session_id($token);
        session_start();
        $_SESSION['user'] = json_encode($user);
        $_SESSION['sitecode'] = self::$sitecode;

        return successJson([
            'token' => $token,
            'sitecode' => self::$sitecode,
            'user_id' => $user['id'],
            'avatar' => $user['avatar']
        ], '登录成功');
    }

    /**
     * 账号注册
     */
    public function reg()
    {
        $now = time();
        $phone = input('phone', '', 'trim');
        $code = input('code', '', 'trim');
        $password = input('password', '', 'trim');
        $openid = input('openid', '', 'trim'); // 小程序的openid
        $tuid = input('tuid', 0, 'intval');
        if (empty($password)) {
            return errorJson('请输入密码');
        }
        if (!verifySmsCode(self::$site_id, 'reg', $phone, $code)) {
            return errorJson('短信验证码错误');
        }
        $isExist = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['phone', '=', $phone]
            ])
            ->find();
        if ($isExist) {
            return errorJson('手机号已存在，可直接登录');
        }

        Db::startTrans();
        try {
            if ($openid) {
                $wxappUser = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['openid', '=', $openid]
                    ])
                    ->whereNull('phone')
                    ->find();
            }
            if (!empty($wxappUser)) {
                Db::name('user')
                    ->where('id', $wxappUser['id'])
                    ->update([
                        'phone' => $phone,
                        'password' => $password,
                        'update_time' => $now
                    ]);
            } else {
                $tuser = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $tuid]
                    ])
                    ->find();
                if (!$tuser) {
                    $tuid = 0;
                }
                $user_id = Db::name('user')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'tuid' => $tuid,
                        'phone' => $phone,
                        'password' => $password,
                        'update_time' => $now,
                        'create_time' => $now
                    ]);
                // 送免费条数
                giveFreeNum(self::$site_id, $user_id);
                // 送邀请人次数
                if ($tuid) {
                    $today = strtotime(date('Y-m-d'));
                    $count = Db::name('user')
                        ->where([
                            ['tuid', '=', $tuid],
                            ['create_time', '>', $today]
                        ])
                        ->count();
                    $setting = getSystemSetting(self::$site_id, 'reward_invite');
                    if (!empty($setting['is_open']) && !empty($setting['max']) && $count < intval($setting['max']) && !empty($setting['num'])) {
                        $reward_num = intval($setting['num']);
                        changeUserBalance($tuid, $reward_num, '邀请朋友奖励');
                        Db::name('reward_invite')
                            ->insert([
                                'site_id' => self::$site_id,
                                'user_id' => $tuid,
                                'way' => 'h5',
                                'newuser_id' => $user_id,
                                'reward_num' => $reward_num,
                                'create_time' => time()
                            ]);
                    }
                }
            }

            Db::commit();
            return successJson('', '注册成功');
        } catch (\Exception $e) {
            Db::rollBack();
            return errorJson(text('注册失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 找回密码
     */
    public function reset()
    {
        $now = time();
        $phone = input('phone', '', 'trim');
        $code = input('code', '', 'trim');
        $password = input('password', '', 'trim');
        if (empty($password)) {
            return errorJson('请输入密码');
        }
        if (!verifySmsCode(self::$site_id, 'reset', $phone, $code)) {
            return errorJson('短信验证码错误');
        }
        $isExist = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['phone', '=', $phone]
            ])
            ->find();
        if (!$isExist) {
            return errorJson('手机号不存在，请检查');
        }

        Db::startTrans();
        try {
            Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['phone', '=', $phone]
                ])
                ->update([
                    'password' => $password,
                    'update_time' => $now
                ]);
            Db::commit();
            return successJson('', '密码修改成功');
        } catch (\Exception $e) {
            Db::rollBack();
            return errorJson(text('修改失败') . ': ' . $e->getMessage());
        }
    }

    public function system()
    {
        $lang = env('lang.default_lang', 'zh-cn');
        $setting = Db::name('setting')
            ->where('site_id', self::$site_id)
            ->find();
        $webSetting = empty($setting['web']) ? [] : json_decode($setting['web'], true);
        $site = Db::name('site')
            ->where([
                ['id', '=', self::$site_id],
                ['is_delete', '=', 0]
            ])
            ->find();
        if (!$site || empty($webSetting['is_open'])) {
            echo json_encode([
                'errno' => 403,
                'message' => '已暂停服务'
            ]);
            exit;
        }

        $systemSetting = getSystemSetting(0, 'system');
        $loginSetting = empty($setting['login']) ? [] : json_decode($setting['login'], true);
        $aiSetting = empty($setting['chatgpt']) ? [] : json_decode($setting['chatgpt'], true);
        $ai4Setting = empty($setting['gpt4']) ? [] : json_decode($setting['gpt4'], true);
        $drawSetting = empty($setting['draw']) ? [] : json_decode($setting['draw'], true);
        $pkSetting = empty($setting['pk']) ? [] : json_decode($setting['pk'], true);
        $batchSetting = empty($setting['batch']) ? [] : json_decode($setting['batch'], true);
        $novelSetting = empty($setting['novel']) ? [] : json_decode($setting['novel'], true);
        $teamSetting = empty($setting['team']) ? [] : json_decode($setting['team'], true);
        $mindSetting = empty($setting['mind']) ? [] : json_decode($setting['mind'], true);

        try {
            // gpt4配置
            $ai4Channel = [];
            $hasModel4 = 0;
            $model4Name = '';
            if (!empty($ai4Setting['is_open'])) {
                $hasModel4 = 1;
                $model4Name = '高级版';
                $ai4Channel = is_string($ai4Setting['channel']) ? [$ai4Setting['channel']] : $ai4Setting['channel'];
            }
            // 普通ai配置
            $aiChannel = is_string($aiSetting['channel']) ? [$aiSetting['channel']] : $aiSetting['channel'];
            $aiChannel = array_merge($aiChannel, $ai4Channel);

            // 汇总成最终AI列表，显示到前端
            $aiList = [];
            foreach ($aiChannel as $aiName) {
                $ai = getAiSetting(self::$site_id, $aiName);
                if (!empty($ai)) {
                    $aiList[] = [
                        'name' => $aiName,
                        'alias' => $ai['alias'] ?? $aiName
                    ];
                }
            }
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }

        // 功能开关
        $writeIsOpen = 1;
        $cosplayIsOpen = 1;
        $drawIsOpen = isset($drawSetting['is_open']) ? intval($drawSetting['is_open']) : 1;
        $pkIsOpen = isset($pkSetting['is_open']) ? intval($pkSetting['is_open']) : 1;
        $batchIsOpen = isset($batchSetting['is_open']) ? intval($batchSetting['is_open']) : 1;
        $novelIsOpen = isset($novelSetting['is_open']) ? intval($novelSetting['is_open']) : 1;
        $teamIsOpen = isset($teamSetting['is_open']) ? intval($teamSetting['is_open']) : 0;
        $mindIsOpen = empty($mindSetting['is_open']) ? 0 : 1;
        $loginWechat = isset($loginSetting['login_wechat']) ? $loginSetting['login_wechat'] : 1;
        $loginPhone = isset($loginSetting['login_phone']) ? $loginSetting['login_phone'] : 0;

        return successJson([
            'logo' => $webSetting['logo'] ?? '',
            'logo_mini' => $webSetting['logo_mini'] ?? '',
            'page_title' => $webSetting['page_title'] ?? '',
            'copyright' => $webSetting['copyright'] ?? '',
            'copyright_link' => $webSetting['copyright_link'] ?? '',
            'icp' => $systemSetting['system_icp'] ?? '',
            'gongan' => $systemSetting['system_gongan'] ?? '',
            'lang' => $lang,
            'login_wechat' => $loginWechat,
            'login_phone' => $loginPhone,
            'hasModel4' => $hasModel4,
            'model4Name' => $model4Name,
            'theme' => '', // light 或 dark
            'drawIsOpen' => $drawIsOpen,
            'writeIsOpen' => $writeIsOpen,
            'cosplayIsOpen' => $cosplayIsOpen,
            'pkIsOpen' => $pkIsOpen,
            'batchIsOpen' => $batchIsOpen,
            'novelIsOpen' => $novelIsOpen,
            'teamIsOpen' => $teamIsOpen,
            'mindIsOpen' => $mindIsOpen,
            'aiList' => $aiList
        ]);
    }

    /**
     * 通知公告
     */
    public function getNotice()
    {
        $platform = input('platform', '', 'trim');
        $now = time();
        $notice = Db::name('notice')
            ->where([
                ['site_id', '=', self::$site_id],
                ['start_time', '<=', $now],
                ['end_time', '>', $now],
                ['platform', 'in', ['all', $platform]]
            ])
            ->field('id,type,content')
            ->order('id desc')
            ->find();
        if ($notice) {
            Db::name('notice')
                ->where('id', $notice['id'])
                ->inc('views', 1)
                ->update();
        }
        unset($notice['id']);
        return successJson($notice);
    }

    public function skin()
    {
        $skin = 'default';
        $platform = input('platform', 'web', 'trim');
        if (!in_array($platform, ['web', 'h5', 'wxapp'])) {
            die('');
        }
        if ($platform == 'web') {
            $webSetting = getSystemSetting(self::$site_id, 'web');
            $skin = !empty($webSetting['skin']) ? $webSetting['skin'] : 'default';
        }

        $script = 'var link = document.createElement("link");';
        $script .= 'link.href="/static/skin/web/' . $skin . '/light.css";';
        $script .= 'link.rel="stylesheet";';
        $script .= 'document.head.appendChild(link);';
        $script .= 'var link2 = document.createElement("link");';
        $script .= 'link2.href="/static/skin/web/' . $skin . '/dark.css";';
        $script .= 'link2.rel="stylesheet";';
        $script .= 'document.head.appendChild(link2);';
        echo $script;
    }

    public function lang()
    {
        $lang = env('lang.default_lang', 'zh-cn');
        echo "window.\$lang = '" . $lang . "'";
    }

    /**
     * H5公众号登录
     */
    public function h5()
    {
        $fromUrl = input('from', '', 'trim');
        $code = input('code', '', 'trim');
        $tuid = input('tuid', 0, 'intval');
        $wxmpConfig = getSystemSetting(self::$site_id, 'wxmp');
        $config = [
            'app_id' => $wxmpConfig['appid'] ?? '',
            'secret' => $wxmpConfig['appsecret'] ?? '',
            'response_type' => 'array',
            'debug' => false
        ];
        $app = \EasyWeChat\Factory::officialAccount($config);
        $oauth = $app->oauth;
        if (!$code) {
            $h5Config = getSystemSetting(self::$site_id, 'h5');
            if (empty($h5Config['is_open'])) {
                return $this->error('此站点已停止服务');
            }
            if (!isset($wxmpConfig['appid'])) {
                return $this->error('请先配置公众号参数');
            }

            $callback = Request::url(true);
            $response = $oauth->scopes(['snsapi_userinfo'])
                ->redirect($callback);
            $response->send();
            exit;
        } else {
            try {
                $user = $oauth->user()->toArray();
                $openid = $user['id'];
                $avatar = $user['avatar'];
                $nickname = $user['nickname'];

                // 登录成功
                $user_id = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['openid_mp', '=', $openid]
                    ])
                    ->value('id');
                if (!$user_id) {
                    $tuser = Db::name('user')
                        ->where([
                            ['site_id', '=', self::$site_id],
                            ['id', '=', $tuid]
                        ])
                        ->find();
                    if (!$tuser) {
                        $tuid = 0;
                    }
                    $user_id = Db::name('user')
                        ->insertGetId([
                            'site_id' => self::$site_id,
                            'openid_mp' => $openid,
                            'avatar' => $avatar,
                            'nickname' => $nickname,
                            'tuid' => $tuid,
                            'create_time' => time()
                        ]);
                    // 送免费条数
                    giveFreeNum(self::$site_id, $user_id);
                    // 送邀请人次数
                    if ($tuid) {
                        $today = strtotime(date('Y-m-d'));
                        $count = Db::name('user')
                            ->where([
                                ['tuid', '=', $tuid],
                                ['create_time', '>', $today]
                            ])
                            ->count();
                        $setting = getSystemSetting(self::$site_id, 'reward_invite');
                        if (!empty($setting['is_open']) && !empty($setting['max']) && $count < intval($setting['max']) && !empty($setting['num'])) {
                            $reward_num = intval($setting['num']);
                            changeUserBalance($tuid, $reward_num, '邀请朋友奖励');
                            Db::name('reward_invite')
                                ->insert([
                                    'site_id' => self::$site_id,
                                    'user_id' => $tuid,
                                    'way' => 'h5',
                                    'newuser_id' => $user_id,
                                    'reward_num' => $reward_num,
                                    'create_time' => time()
                                ]);
                        }
                    }
                }

                $user = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $user_id]
                    ])
                    ->find();

                session_start();
                $_SESSION['user'] = json_encode($user);
                $_SESSION['sitecode'] = self::$sitecode;

                header('location:/h5/#/' . $fromUrl);
                exit;
            } catch (\Exception $e) {
                $this->error($e->getMessage());
            }
        }
    }

    /**
     * @param $msg
     * 在页面上输出错误信息
     */
    private function error($message)
    {
        return view('pay/error', ['message' => $message]);
    }
}
