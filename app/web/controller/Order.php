<?php

namespace app\web\controller;

use think\facade\Db;

class Order extends Base
{
    /**
     * 获取充值套餐
     */
    public function getGoodsList()
    {
        $type = input('type', 'goods', 'trim');
        if (!in_array($type, ['vip', 'goods', 'draw', 'gpt4', 'model4'])) {
            return errorJson('参数错误');
        }
        if ($type == 'model4') {
            $type = 'gpt4';
        }
        $dbName = $type;

        $list = Db::name($dbName)
            ->where([
                ['site_id', '=', self::$site_id],
                ['status', '=', 1]
            ])
            ->field('id,title,price,market_price,num,hint,desc,is_default')
            ->order('weight desc, id asc')
            ->select()->each(function ($item) {
                if ($item['desc']) {
                    $item['desc'] = explode("\n", $item['desc']);
                } else {
                    $item['desc'] = [];
                }

                return $item;
            })->toArray();

        return successJson($list);
    }

    public function createOrder()
    {
        try {
            $platform = input('platform', 'web', 'trim');
            $type = input('type', 'goods', 'trim');
            $goods_id = input('goods_id', 0, 'intval');
            if (!in_array($type, ['vip', 'goods', 'draw', 'model4', 'gpt4'])) {
                return errorJson('参数错误');
            }
            $type = $type == 'model4' ? 'gpt4' : $type;
            $dbName = $type;

            $out_trade_no = $this->createOrderNo();

            $goods = Db::name($dbName)
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $goods_id]
                ])
                ->find();
            if ($goods['status'] != 1) {
                return errorJson('该套餐已下架，请刷新页面重新提交');
            }
            $total_fee = $goods['price'];
            $num = $goods['num'];

            // 推荐人 + 计算分佣
            $commission1 = 0;
            $commission1_fee = 0;
            $commission2 = 0;
            $commission2_fee = 0;
            $commissionSetting = getSystemSetting(self::$site_id, 'commission');
            if (!empty($commissionSetting['is_open'])) {
                $bili_1 = floatval($commissionSetting['bili_1']);
                $bili_2 = floatval($commissionSetting['bili_2']);

                $tuid = Db::name('user')
                    ->where('id', self::$user['id'])
                    ->value('tuid');
                if (!empty($tuid)) {
                    $tuser = Db::name('user')
                        ->where('id', $tuid)
                        ->find();
                    if ($tuser && $tuser['commission_level'] > 0) {
                        $commission1 = $tuid;
                        $commission1_fee = intval($total_fee * $bili_1 / 100);
                        if ($tuser['commission_pid']) {
                            $puser = Db::name('user')
                                ->where('id', $tuser['commission_pid'])
                                ->find();
                            if ($puser && $puser['commission_level'] > 0) {
                                $commission2 = $tuser['commission_pid'];
                                $commission2_fee = intval($total_fee * $bili_2 / 100);
                            }
                        }
                    }
                }
            }

            $now = time();
            $order_id = Db::name('order')->insertGetId([
                'site_id' => self::$site_id,
                'platform' => $platform,
                'goods_id' => $type == 'goods' ? $goods_id : 0,
                'draw_id' => $type == 'draw' ? $goods_id : 0,
                'gpt4_id' => $type == 'gpt4' ? $goods_id : 0,
                'vip_id' => $type == 'vip' ? $goods_id : 0,
                'user_id' => self::$user['id'],
                'out_trade_no' => $out_trade_no,
                'transaction_id' => '',
                'total_fee' => $total_fee,
                'pay_type' => 'wxpay',
                'status' => 0,
                'num' => $num,
                'commission1' => $commission1,
                'commission2' => $commission2,
                'commission1_fee' => $commission1_fee,
                'commission2_fee' => $commission2_fee,
                'create_time' => $now
            ]);

            $wxmpConfig = getSystemSetting(self::$site_id, 'wxmp');
            $payConfig = getSystemSetting(self::$site_id, 'pay');
            $notifyUrl = 'https://' . $_SERVER['HTTP_HOST'] . '/api.php/notify/wxpay';
            if ($platform == 'web') {
                $tradeType = 'native';
                $appid = $wxmpConfig['appid'];
            } elseif ($platform == 'h5') {
                $tradeType = input('trade_type', 'jsapi', 'trim');
                if (empty(self::$user['openid_mp'])) {
                    $tradeType = 'native';
                }
                $appid = $wxmpConfig['appid'];
                $openid = self::$user['openid_mp'];
            } elseif ($platform == 'wxapp') {
                $tradeType = 'jsapi';
                $wxappConfig = getSystemSetting(self::$site_id, 'wxapp');
                $appid = $wxappConfig['appid'];
                $openid = self::$user['openid'];
            }
            $app = \EasyWeChat\Factory::payment([
                'app_id' => $appid,
                'mch_id' => $payConfig['mch_id'],
                'key' => $payConfig['key'],
                'notify_url' => $notifyUrl
            ]);
            if ($tradeType == 'native') {
                $result = $app->order->unify([
                    'trade_type' => 'NATIVE',
                    'product_id' => $type . '_' . $goods_id,
                    'out_trade_no' => $out_trade_no,
                    'body' => '订购商品',
                    'total_fee' => $total_fee
                ]);
                if (!empty($result['return_code']) && $result['return_code'] == 'FAIL') {
                    return errorJson($result['return_msg']);
                }
                return successJson([
                    'order_id' => $order_id,
                    'total_fee' => $total_fee,
                    'pay_url' => $result['code_url']
                ]);
            } elseif ($tradeType == 'jsapi') {
                $result = $app->order->unify([
                    'trade_type' => 'JSAPI',
                    'out_trade_no' => $out_trade_no,
                    'body' => '订购商品',
                    'total_fee' => $total_fee,
                    'openid' => $openid,
                    'notify_url' => $notifyUrl
                ]);
                if (!empty($result['return_code']) && $result['return_code'] == 'FAIL') {
                    return errorJson($result['return_msg']);
                }
                $jssdk = $app->jssdk;
                $jssdkConfig = $jssdk->sdkConfig($result['prepay_id']);
                $jssdkConfig['timeStamp'] = $jssdkConfig['timestamp'];
                successJson($jssdkConfig);
            }
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function checkPay()
    {
        $order_id = input('order_id', 0, 'intval');
        $order = Db::name('order')
            ->where('id', $order_id)
            ->find();
        if ($order && $order['status'] == 1) {
            $ispay = 1;
        } else {
            $ispay = 0;
        }
        return successJson([
            'ispay' => $ispay
        ]);
    }

    /**
     * 创建订单号
     */
    private function createOrderNo()
    {
        return 'Chat' . date('YmdHis') . rand(1000, 9999);
    }
}
