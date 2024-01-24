<?php

namespace app\web\controller;

use think\facade\Db;
use think\facade\Request;

class User extends Base
{
    public function checkLogin()
    {
        return successJson();
    }

    public function info()
    {
        $now = time();
        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->find();
        if (!$user) {
            die(json_encode(['errno' => 403, 'message' => text('请登录')]));
        }
        // 分销入口
        $commissionSetting = getSystemSetting(self::$site_id, 'commission');
        $commissionIsOpen = empty($commissionSetting['is_open']) ? 0 : 1;

        return successJson([
            'user_id' => $user['id'],
            'nickname' => $user['nickname'] ?? text('未设置昵称'),
            'avatar' => $user['avatar'] ? mediaUrl($user['avatar'], true) : '',
            'phone' => $user['phone'] ? substr($user['phone'], 0, 3) . '****' . substr($user['phone'], -3) : '',
            'commission_is_open' => $commissionIsOpen,
            'is_commission' => $user['commission_level'] ? 1 : 0,
            'vip_expire_time' =>  $user['vip_expire_time'] > $now ? date('Y-m-d', $user['vip_expire_time']) : '',
            'balance' => $user['balance'] ?? 0,
            'balance_draw' => $user['balance_draw'] ?? 0,
            'balance_gpt4' => floor($user['balance_gpt4'] / 100) / 100
        ]);
    }

    /**
     * 获取账户余额
     */
    public function getBalance()
    {
        $user = Db::name('user')
            ->where('id', self::$user['id'])
            ->find();
        $now = time();
        if ($user['vip_expire_time'] > $now) {
            $vip_expire_time = date('Y-m-d', $user['vip_expire_time']);
        } else {
            $vip_expire_time = '';
        }
        return successJson([
            'balance' => $user['balance'] ?? 0,
            'balance_draw' => $user['balance_draw'] ?? 0,
            'balance_model4' => floor($user['balance_gpt4'] / 100) / 100,
            'vip_expire_time' => $vip_expire_time
        ]);
    }

    public function setUserInfo()
    {
        $avatar = input('avatar', '', 'trim');
        $nickname = input('nickname', '', 'trim');

        $nicknameClear = wordFilter($nickname);
        if ($nicknameClear != $nickname) {
            return errorJson('昵称包含敏感内容');
        }

        $user = Db::name('user')
            ->where('id', self::$user['id'])
            ->find();
        if ($user) {
            Db::name('user')
                ->where('id', self::$user['id'])
                ->update([
                    'avatar' => $avatar,
                    'nickname' => $nickname,
                    'update_time' => time()
                ]);
            return successJson('', '保存成功');
        } else {
            return errorJson('请刷新页面重试');
        }
    }

    public function getAccounts()
    {
        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->field('openid_mp,phone')
            ->find();
        return successJson([
            'phone' => $user['phone'] ? $user['phone'] : '',
            'openid' => $user['openid_mp'] ? $user['openid_mp'] : ''
        ]);
    }

    public function bindPhone()
    {
        $now = time();
        $phone = input('phone', '', 'trim');
        $code = input('code', '', 'trim');
        $password = input('password', '', 'trim');
        if (!$phone) {
            return errorJson('请输入手机号');
        }
        if (!$password) {
            return errorJson('请设置登录密码');
        }
        if (!verifySmsCode(self::$site_id, 'bind', $phone, $code)) {
            return errorJson('短信验证码错误');
        }
        $isExist = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['phone', '=', $phone],
                ['id', '<>', self::$user['id']]
            ])
            ->find();
        if ($isExist) {
            return errorJson('手机号已被占用，请检查');
        }

        Db::startTrans();
        try {
            Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', self::$user['id']]
                ])
                ->update([
                    'phone' => $phone,
                    'password' => $password,
                    'update_time' => $now
                ]);
            Db::commit();
            return successJson('', '绑定成功');
        } catch (\Exception $e) {
            Db::rollBack();
            return errorJson(text('绑定失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * pc端绑定微信账号
     */
    public function bindWechat()
    {
        $code = input('code', '', 'trim');

        $codeInfo = Db::name('pclogin')
            ->where([
                ['site_id', '=', self::$site_id],
                ['code', '=', $code]
            ])
            ->order('id desc')
            ->find();
        if (!$codeInfo || empty($codeInfo['openid'])) {
            return successJson([
                'success' => 0
            ]);
        }

        // code用一次就过期
        Db::name('pclogin')
            ->where('id', $codeInfo['id'])
            ->delete();
        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '<>', self::$user['id']],
                ['openid_mp', '=', $codeInfo['openid']]
            ])
            ->find();
        if ($user) {
            return successJson([
                'success' => 2
            ], '此微信号已被其他账号使用，请更换');
        }

        Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->update([
                'openid_mp' => $codeInfo['openid']
            ]);
        return successJson([
            'success' => 1
        ], '绑定成功');
    }

    /**
     * h5绑定微信账号
     */
    public function authAndBindWechat()
    {
        $code = input('code', '', 'trim');
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
            if (!isset($wxmpConfig['appid'])) {
                return view('user/bindWechat', [
                    'state' => 'error',
                    'message' => '请先配置公众号参数'
                ]);
            }

            $callback = Request::url(true);
            $response = $oauth->scopes(['snsapi_base'])
                ->redirect($callback);
            $response->send();
            exit;
        } else {
            try {
                $user = $oauth->user()->toArray();
                $openid = $user['id'];

                // 登录成功
                $user =  Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['openid_mp', '=', $openid],
                        ['id', '<>', self::$user['id']]
                    ])
                    ->find();

                if ($user) {
                    return view('user/bindWechat', [
                        'state' => 'error',
                        'message' => text('此微信已注册到其他账号，无法绑定')
                    ]);
                } else {
                    Db::name('user')
                        ->where([
                            ['site_id', '=', self::$site_id],
                            ['id', '<>', self::$user['id']]
                        ])
                        ->update([
                            'openid_mp' => $openid
                        ]);
                    return view('user/bindWechat', [
                        'state' => 'success',
                        'message' => text('绑定成功')
                    ]);
                }
            } catch (\Exception $e) {
                return view('user/bindWechat', [
                    'state' => 'error',
                    'message' => $e->getMessage()
                ]);
            }
        }
    }

    public function setUserAvatar()
    {
        $avatar = input('avatar', '', 'trim');
        if (empty($avatar)) {
            return errorJson('图片地址不能为空');
        }
        Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->update([
                'avatar' => $avatar
            ]);
        return successJson('修改成功');
    }

    public function setUserNickname()
    {
        $nickname = input('nickname', '', 'trim');
        if (empty($nickname)) {
            return errorJson('请输入昵称');
        }
        $nicknameClear = wordFilter($nickname);
        if ($nicknameClear != $nickname) {
            return errorJson('昵称包含敏感内容');
        }
        Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->update([
                'nickname' => $nickname
            ]);
        return successJson('保存成功');
    }

    /**
     * 退出登录
     */
    public function logout()
    {
        session_start();
        $_SESSION['user'] = null;
        $_SESSION['sitecode'] = null;
        self::$user = null;
        return successJson('', '已退出登录');
    }


    /**
     * 意见反馈
     */
    public function feedback()
    {
        $type = input('type', '', 'trim');
        $content = input('content', '', 'trim');
        $phone = input('phone', '', 'trim');
        if (empty($content)) {
            return errorJson('请输入反馈内容');
        }
        $today = strtotime(date('Y-m-d'));
        $count = Db::name('feedback')
            ->where([
                ['user_id', '=', self::$user['id']],
                ['create_time', '>', $today]
            ])
            ->count();
        if ($count >= 5) {
            return errorJson('今天提交太多了，明天再来！');
        }
        try {
            Db::name('feedback')
                ->insert([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'type' => $type,
                    'content' => $content,
                    'phone' => $phone,
                    'create_time' => time()
                ]);
            return successJson('', '提交成功，谢谢！');
        } catch (\Exception $e) {
            return errorJson(text('提交失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 卡密信息
     */
    public function getCardInfo()
    {
        $code = input('code', '', 'trim');
        $card = Db::name('card')
            ->where([
                ['site_id', '=', self::$site_id],
                ['code', '=', $code]
            ])
            ->field('type,val,user_id,bind_time')
            ->find();
        if (!$card) {
            return errorJson('卡密输入有误');
        }
        if ($card['user_id']) {
            $card['bind_time'] = date('Y-m-d', $card['bind_time']);
        }
        unset($card['user_id']);

        return successJson($card);
    }

    /**
     * 使用卡密
     */
    public function bindCard()
    {
        $code = input('code', '', 'trim');
        $card = Db::name('card')
            ->where([
                ['site_id', '=', self::$site_id],
                ['code', '=', $code]
            ])
            ->find();
        if (!$card) {
            return errorJson('卡密输入有误');
        }
        if ($card['user_id']) {
            return errorJson('此卡密已被使用');
        }
        if (!in_array($card['type'], ['times', 'draw', 'gpt4', 'vip']) || intval($card['val']) <= 0) {
            return errorJson('卡密信息有误，请联系客服');
        }

        Db::startTrans();
        try {
            if ($card['type'] == 'times') {
                changeUserBalance(self::$user['id'], $card['val'], '卡密充值');
            }
            elseif ($card['type'] == 'draw') {
                changeUserDrawBalance(self::$user['id'], $card['val'], '卡密充值');
            }
            elseif ($card['type'] == 'gpt4') {
                changeUserGpt4Balance(self::$user['id'], $card['val'] * 10000, '卡密充值');
            }
            elseif ($card['type'] == 'vip') {
                $today = strtotime(date('Y-m-d 23:59:59', time()));
                $user = Db::name('user')
                    ->where('id', self::$user['id'])
                    ->find();
                $vip_expire_time = max($today, $user['vip_expire_time']);
                $vip_expire_time = strtotime('+' . $card['val'] . ' month', $vip_expire_time);
                Db::name('user')
                    ->where('id', self::$user['id'])
                    ->update([
                        'vip_expire_time' => $vip_expire_time
                    ]);
                Db::name('user_vip_logs')
                    ->insert([
                        'site_id' => self::$site_id,
                        'user_id' => self::$user['id'],
                        'vip_expire_time' => $vip_expire_time,
                        'desc' => '卡密充值',
                        'create_time' => time()
                    ]);
            }
            Db::name('card')
                ->where('id', $card['id'])
                ->update([
                    'user_id' => self::$user['id'],
                    'bind_time' => time()
                ]);
            Db::commit();
            return successJson('', '兑换成功！');
        } catch (\Exception $e) {
            Db::rollback();
            return errorJson(text('操作失败') . ': ' . $e->getMessage());
        }
    }
}
