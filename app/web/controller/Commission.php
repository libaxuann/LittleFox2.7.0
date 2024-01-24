<?php

namespace app\web\controller;

use think\facade\Request;
use think\facade\Db;

class Commission extends Base
{
    public function __construct()
    {
        parent::__construct();
        // 分销入口
        $action = Request::action();
        if (!in_array($action, ['getShare', 'makePoster'])) {
            $commissionSetting = getSystemSetting(self::$site_id, 'commission');
            if (empty($commissionSetting['is_open'])) {
                return errorJson('推广功能已关闭，如有疑问请联系平台客服');
            }
        }
    }

    public function index()
    {
        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->find();
        if (!$user['commission_level']) {
            return successJson('', '不是推广员');
        }

        // 队员数、上级昵称、等级
        $commission_title = '推广员';
        $member_count = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['commission_level', '>', 0],
                ['commission_pid', '=', $user['id']],
                ['is_delete', '=', 0]
            ])
            ->count();
        if ($user['commission_pid']) {
            $puser = Db::name('user')
                ->where('id', $user['commission_pid'])
                ->find();
            if ($puser) {
                $commission_title = text('推荐人') . ':' . $puser['nickname'];
            }
        }
        // 订单数
        $order_count = Db::name('order')
            ->where([
                ['site_id', '=', self::$site_id],
                ['commission1|commission2', '=', $user['id']],
                ['pay_time', '>', 0],
                ['is_refund', '=', 0]
            ])
            ->count();
        // 直推用户数
        $tuser_count = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['tuid', '=', $user['id']],
                ['is_delete', '=', 0]
            ])
            ->count();

        return successJson([
            'member' => [
                'nickname' => $user['nickname'],
                'avatar' => $user['avatar'],
                'commission_title' => $commission_title,
                // 'commission_puser' => $commission_puser,
                'commission_pid' => $user['commission_pid']
            ],
            'commission' => [
                'total' => $user['commission_total'] / 100,
                'paid' => $user['commission_paid'] / 100,
                'money' => $user['commission_money'] / 100,
                'order_count' => $order_count,
                'member_count' => $member_count,
                'tuser_count' => $tuser_count
            ]
        ]);
    }

    public function apply()
    {
        $now = time();
        $name = input('name', '', 'trim');
        $phone = input('phone', '', 'trim');
        $pid = input('pid', 0, 'intval');

        // 判断当前身份是不是代理商
        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->find();
        if ($user['commission_level']) {
            return errorJson('你已经是推广员了，无需重复申请');
        }

        // 判断有没有正在处理中的申请
        $info = Db::name('commission_apply')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']]
            ])
            ->order('id desc')
            ->find();
        if ($info) {
            if ($info['status'] == 0) {
                return errorJson('有正在审核中的申请单，请勿重复提交');
            }
        }

        // 判断输入的表单内容
        if (empty($name)) {
            return errorJson('请输入姓名');
        }
        if (empty($phone)) {
            return errorJson('请输入手机号');
        }

        Db::startTrans();
        try {
            if ($pid) {
                $puser = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $pid]
                    ])
                    ->find();
                if (!$puser || !$puser['commission_level']) {
                    $pid = 0;
                }
            } elseif ($user['tuid']) {
                // 以推荐人作为上级
                $puser = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $user['tuid']]
                    ])
                    ->find();
                if ($puser && $puser['commission_level']) {
                    $pid = $puser['id'];
                }
            }

            $applyId = Db::name('commission_apply')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'level' => 1,
                    'pid' => $pid,
                    'name' => $name,
                    'phone' => $phone,
                    'status' => 0,
                    'create_time' => $now
                ]);

            // 自动通过审核
            $setting = getSystemSetting(self::$site_id, 'commission');
            if (!empty($setting['auto_audit'])) {
                Db::name('commission_apply')
                    ->where('id', $applyId)
                    ->update([
                        'status' => 1
                    ]);
                Db::name('user')
                    ->where('id', self::$user['id'])
                    ->update([
                        'realname' => $name,
                        'phone' => $phone,
                        'tuid' => $pid ? $pid : self::$user['tuid'],
                        'commission_level' => 1,
                        'commission_pid' => $pid,
                        'commission_time' => $now
                    ]);
                $message = '提交成功';
            } else {
                $message = '提交成功，请等待审核';
            }

            Db::commit();
            return successJson('', $message);
        } catch (\Exception $e) {
            Db::rollback();
            return errorJson('提交失败，请重试');
        }
    }

    public function getLastApply()
    {
        $info = Db::name('commission_apply')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']]
            ])
            ->field('name,phone,status,reject_reason,create_time')
            ->order('id desc')
            ->find();
        if ($info) {
            $info['create_time'] = date('Y-m-d H:i', $info['create_time']);
        }
        return successJson($info);
    }

    public function memberList()
    {
        $page = input('page', 1, 'intval');
        $page = max(1, $page);
        $pagesize = 10;
        $list = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['commission_level', '>', 0],
                ['commission_pid', '=', self::$user['id']],
                ['is_delete', '=', 0]
            ])
            ->page($page, $pagesize)
            ->field('id,avatar,nickname,commission_time')
            ->order('commission_time desc')
            ->select()->each(function ($item) {
                $item['commission_time'] = date('Y-m-d H:i', $item['commission_time']);
                $item['order_count'] = Db::name('order')
                    ->where([
                        ['commission1', '=', $item['id']],
                        ['pay_time', '>', 0],
                        ['is_refund', '=', 0]
                    ])
                    ->count();
                unset($item['id']);
                return $item;
            });
        return successJson($list);
    }

    /**
     * 我推广的用户
     */
    public function tuserList()
    {
        $type = input('type', 1, 'intval');
        $page = input('page', 1, 'intval');
        $page = max(1, $page);
        $pagesize = 15;

        if ($type == 1) {
            // 直推用户
            $where[] = ['tuid', '=', self::$user['id']];
        } else {
            // 间推用户
            $ids = Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['tuid', '=', self::$user['id']],
                    ['is_delete', '=', 0]
                ])
                ->column('id');
            $where[] = ['tuid', 'in', $ids];
        }
        $list = Db::name('user')
            ->where($where)
            ->page($page, $pagesize)
            ->field('id,avatar,nickname,commission_level,create_time')
            ->order('id desc')
            ->select()->each(function ($item) {
                $item['create_time'] = date('Y-m-d H:i', $item['create_time']);
                $item['order_count'] = Db::name('order')
                    ->where([
                        ['user_id', '=', $item['id']],
                        ['pay_time', '>', 0],
                        ['is_refund', '=', 0]
                    ])
                    ->count();
                return $item;
            });
        return successJson($list);
    }

    public function orderList()
    {
        $page = input('page', 1, 'intval');
        $page = max(1, $page);
        $pagesize = 10;
        $where = [
            ['site_id', '=', self::$site_id],
            ['commission1|commission2', '=', self::$user['id']],
            ['status', '>', 0]
        ];
        $list = Db::name('order')
            ->where($where)
            ->page($page, $pagesize)
            ->field('id,user_id,out_trade_no,total_fee,commission1,commission1_fee,commission2,commission2_fee,pay_time,create_time')
            ->order('id desc')
            ->select()->each(function ($item) {
                $user = Db::name('user')
                    ->where('id', $item['user_id'])
                    ->field('avatar,nickname')
                    ->find();
                $item['avatar'] = $user['avatar'];
                $item['nickname'] = $user['nickname'];
                $item['total_fee'] = $item['total_fee'] / 100;
                $item['pay_time'] = date('Y-m-d H:i:s', $item['pay_time']);
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                if ($item['commission1']) {
                    $commission1 = Db::name('user')
                        ->where('id', $item['commission1'])
                        ->field('avatar,nickname')
                        ->find();
                    if ($commission1) {
                        $item['commission1'] = [
                            'avatar' => $commission1['avatar'],
                            'nickname' => $commission1['nickname'],
                            'fee' => $item['commission1_fee'] / 100
                        ];
                    } else {
                        unset($item['commission1']);
                    }
                }
                if ($item['commission2']) {
                    $commission2 = Db::name('user')
                        ->where('id', $item['commission2'])
                        ->field('avatar,nickname')
                        ->find();
                    if ($commission2) {
                        $item['commission2'] = [
                            'avatar' => $commission2['avatar'],
                            'nickname' => $commission2['nickname'],
                            'fee' => $item['commission2_fee'] / 100
                        ];
                    } else {
                        unset($item['commission2']);
                    }

                }
                unset($item['commission1_fee'], $item['commission2_fee']);
                return $item;

            });
        return successJson($list);
    }

    public function billList()
    {
        $type = input('type', 'all', 'trim');
        $page = input('page', 1, 'intval');
        $page = max(1, $page);
        $pagesize = 20;

        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']]
        ];
        if ($type == 'is_lock') {
            $where[] = ['type', '=', 1];
            $where[] = ['is_lock', '=', 1];
        }
        $list = Db::name('commission_bill')
            ->where($where)
            ->field('id,order_id,money,type,title,is_lock,create_time')
            ->order('id desc')
            ->page($page, $pagesize)
            ->select()->each(function ($item) {
                $item['money'] = $item['money'] / 100;
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                return $item;
            });

        return successJson($list);
    }

    public function lastWithdraw()
    {
        $info = Db::name('commission_withdraw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']]
            ])
            ->field('bank_name,account_name,account_number')
            ->order('id desc')
            ->find();
        if (!$info) {
            return successJson([
                'bank_name' => '微信零钱',
                'account_name' => '',
                'account_number' => ''
            ]);
        }
        return successJson([
            'bank_name' => $info['bank_name'],
            'account_name' => $info['account_name'],
            'account_number' => $info['account_number']
        ]);
    }

    public function withdrawList()
    {
        $page = input('page', 1, 'intval');
        $page = max(1, $page);
        $pagesize = 10;
        $list = Db::name('commission_withdraw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']]
            ])
            ->field('id,money,bank_name,account_name,account_number,status,reject_reason,create_time')
            ->order('id desc')
            ->page($page, $pagesize)
            ->select()->each(function ($item) {
                $item['money'] = $item['money'] / 100;
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                return $item;
            });

        return successJson($list);
    }

    public function withdraw()
    {
        $money = input('money', '', 'trim');
        $bank_name = input('bank_name', '', 'trim');
        $account_name = input('account_name', '', 'trim');
        $account_number = input('account_number', '', 'trim');
        $qrcode = input('qrcode', '', 'trim');

        if ($account_name == '') {
            return errorJson('请填写户名');
        }
        if ($bank_name == '微信零钱' && !$qrcode) {
            return errorJson('请上传微信收款码');
        }
        if ($money * 100 <= 0) {
            return errorJson('参数错误');
        }
        if ($bank_name == '支付宝' && !$account_number) {
            return errorJson('请填写支付宝账号');
        }
        $info = Db::name('commission_withdraw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['status', '=', 0]
            ])
            ->find();
        if ($info) {
            return errorJson('有正在审核中的提现，请审核之后再提交');
        }

        $user = Db::name('user')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', self::$user['id']]
            ])
            ->find();
        // 验证金额
        if (intval($user['commission_money']) < intval($money) * 100) {
            return errorJson('可提现余额不足，请刷新后重试');
        }

        Db::startTrans();
        try {
            $withdraw_id = Db::name('commission_withdraw')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'money' => $money * 100,
                    'bank_name' => $bank_name,
                    'account_name' => $account_name,
                    'account_number' => ($bank_name == '支付宝' ? $account_number : ''),
                    'qrcode' => ($bank_name == '微信零钱' ? $qrcode : ''),
                    'create_time' => time()
                ]);
            Db::name('user')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', self::$user['id']]
                ])
                ->dec('commission_money', $money * 100)
                ->update();
            Db::name('commission_bill')
                ->insert([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'order_id' => $withdraw_id,
                    'title' => '申请提现',
                    'type' => 2,
                    'money' => $money * 100,
                    'create_time' => time()
                ]);
            Db::commit();
            return successJson('', '提交成功，请等待财务审核打款，预计1-3个工作日');
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return errorJson(text('提交失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 邀请下单海报
     */
    public function poster()
    {

    }

    /**
     * 分销协议
     */
    public function agreement()
    {
        $setting = getSystemSetting(self::$site_id, 'commission');
        $content = !empty($setting['agreement']) ? $setting['agreement'] : '';
        $contents = $content ? explode("\n", $content) : [];
        return successJson($contents);
    }

    /**
     * @return string
     * 获取分享海报、分享文案
     */
    public function getShare()
    {
        $platform = input('platform', 'wxapp', 'trim');
        // 获取分享文案
        $defaultText = '';
        $textArr = Db::name('share_text')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1]
            ])
            ->order('weight desc, id asc')
            ->field('content,is_default')
            ->select()->toArray();
        if (!empty($textArr)) {
            foreach ($textArr as &$v) {
                $v['content'] = str_replace("\n", "<br>", $v['content']);
                if ($v['is_default'] == 1) {
                    $defaultText = $v['content'];
                }
            }
            if (empty($defaultText)) {
                $defaultText = $textArr[0]['content'];
            }
        }

        // 获取分享海报
        $defaultHaibao = 0;
        $haibaoArr = Db::name('share_haibao')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1]
            ])
            ->order('weight desc, id asc')
            ->field('bg,bg_w,bg_h,hole_w,hole_h,hole_x,hole_y,is_default')
            ->select()->toArray();
        if (!empty($haibaoArr)) {
            foreach ($haibaoArr as $k => &$v) {
                if ($v['is_default'] == 1) {
                    $defaultHaibao = $k;
                }
                $v['scale'] = intval(500 / $v['bg_h'] * 100) / 100;
            }
        }

        // 生成分享二维码
        if ($platform == 'wxapp') {
            $page = 'pages/index/index';
            $scene = 'tuid=' . self::$user['id'];
            $qrcode = './upload/qrcode/share/' . substr(md5($page . $scene), 0, 16) . '.png';
            if (!is_dir(dirname($qrcode))) {
                mkdir(dirname($qrcode), 0755, true);
            }
            $setting = getSystemSetting(self::$site_id, 'wxapp');
            $Wxapp = new \Weixin\Wxapp($setting['appid'], $setting['appsecret']);
            $result = $Wxapp->getCodeUnlimit($scene, $page, 400);
            if (is_array($result) && $result['errno']) {
                return errorJson($result['message']);
            }
            file_put_contents($qrcode, $result);
        } elseif ($platform == 'h5') {
            $sitecode = Db::name('site')
                ->where('id', self::$site_id)
                ->value('sitecode');
            $h5url = 'https://' . $_SERVER['HTTP_HOST'] . '/h5/?';
            if (empty($sitecode)) {
                $h5url .= 'tuid=' . self::$user['id'];
            } else {
                $h5url .= $sitecode . '&tuid=' . self::$user['id'];
            }
            $qrcode = './upload/qrcode/share/' . substr(md5($h5url), 0, 16) . '.png';
            $FoxQrcode = new \FoxQrcode\code();
            $FoxQrcode->png($h5url, $qrcode, 15);
        }

        return successJson([
            'textArr' => $textArr,
            'haibaoArr' => $haibaoArr,
            'defaultHaibao' => $defaultHaibao,
            'defaultText' => $defaultText,
            'qrcode' => mediaUrl($qrcode, true),
            'h5url' => isset($h5url) ? $h5url : ''
        ]);
    }

    /**
     * 生成合成的海报图片
     */
    public function makePoster()
    {
        $bg = input('bg', '', 'urldecode');
        $qrcode = input('qrcode', '', 'urldecode');
        $hole_x = input('hole_x', 0, 'intval');
        $hole_y = input('hole_y', 0, 'intval');
        $hole_w = input('hole_w', 0, 'intval');
        $hole_h = input('hole_h', 0, 'intval');
        $bg = str_replace('https://' . $_SERVER['HTTP_HOST'] . '/', './', $bg);
        $qrcode = str_replace('https://' . $_SERVER['HTTP_HOST'] . '/', './', $qrcode);

        $qrcodeImg = imagecreatefrompng($qrcode);
        $qrcodeWidth = imagesx($qrcodeImg);
        $qrcodeHeight = imagesy($qrcodeImg);
        if (strpos($bg, '.png') !== false) {
            $bgImg = imagecreatefrompng($bg);
        } elseif (strpos($bg, '.jpg') !== false) {
            $bgImg = imagecreatefromjpeg($bg);
        }

        imagecopyresized($bgImg, $qrcodeImg, $hole_x, $hole_y, 0, 0, $hole_w, $hole_h, $qrcodeWidth, $qrcodeHeight);

        ob_clean();
        header('Content-type:image/png');
        imagepng($bgImg);
        imagedestroy($bgImg);
        imagedestroy($qrcodeImg);
        exit;
    }
}