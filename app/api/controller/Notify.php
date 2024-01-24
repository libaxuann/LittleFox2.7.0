<?php

namespace app\api\controller;

use Wxpay\v2\WxPayConfig;
use Wxpay\v2\lib\WxPayNotifyResults;
use think\facade\Db;

class Notify
{
    public function wxpay()
    {
        $xml = file_get_contents("php://input");
        // file_put_contents('./payResultWxpay.txt', "$xml\n\n", 8);
        libxml_disable_entity_loader(true);
        $data = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);

        $result_code = $data['result_code'];
        $out_trade_no = $data['out_trade_no'];      // 商户订单号
        $transaction_id = $data['transaction_id'];  // 微信流水单号
        $time_end = $data['time_end'];              // 支付时间
        // $total_fee = $data['total_fee'];         // 交易金额

        // 验签
        $order = Db::name('order')
            ->where('out_trade_no', $out_trade_no)
            ->find();
        if (!$order || $order['status'] != 0) {
            self::wxpayAnswer('FAIL', '订单错误');
        }
        $payConfig = getSystemSetting($order['site_id'], 'pay');
        $config = new WxPayConfig();
        $config->SetKey($payConfig['key']);
        $Notify = new WxPayNotifyResults();
        $checkSign = $Notify->Init($config, $xml);

        if (!$checkSign) {
            self::wxpayAnswer('FAIL', '签名错误');
        }

        if ($result_code == 'SUCCESS') {
            Db::startTrans();
            try {
                // 改订单状态
                Db::name('order')
                    ->where('out_trade_no', $out_trade_no)
                    ->update([
                        'status' => 1,
                        'transaction_id' => $transaction_id,
                        'pay_time' => strtotime($time_end)
                    ]);
                if ($order['goods_id']) {
                    // 加对话余额
                    changeUserBalance($order['user_id'], $order['num'], '充值次数');
                    // 加已售数
                    Db::name('goods')
                        ->where('id', $order['goods_id'])
                        ->inc('sales', 1)
                        ->update();
                } elseif ($order['draw_id']) {
                    // 加绘画余额
                    changeUserDrawBalance($order['user_id'], $order['num'], '充值次数');
                    // 加已售数
                    Db::name('draw')
                        ->where('id', $order['draw_id'])
                        ->inc('sales', 1)
                        ->update();
                }  elseif ($order['gpt4_id']) {
                    // 加GPT4余额
                    changeUserGpt4Balance($order['user_id'], $order['num'] * 10000, '充值余额');
                    // 加已售数
                    Db::name('gpt4')
                        ->where('id', $order['gpt4_id'])
                        ->inc('sales', 1)
                        ->update();
                } elseif ($order['vip_id']) {
                    // 加用户会员时长
                    $today = strtotime(date('Y-m-d 23:59:59', time()));
                    $user = Db::name('user')
                        ->where('id', $order['user_id'])
                        ->find();
                    $vip_expire_time = max($today, $user['vip_expire_time']);
                    $vip_expire_time = strtotime('+' . $order['num'] . ' month', $vip_expire_time);
                    Db::name('user')
                        ->where('id', $order['user_id'])
                        ->update([
                            'vip_expire_time' => $vip_expire_time
                        ]);
                    Db::name('user_vip_logs')
                        ->insert([
                            'site_id' => $order['site_id'],
                            'user_id' => $order['user_id'],
                            'vip_expire_time' => $vip_expire_time,
                            'desc' => '购买套餐',
                            'create_time' => time()
                        ]);
                    // 加已售数
                    Db::name('vip')
                        ->where('id', $order['vip_id'])
                        ->inc('sales', 1)
                        ->update();
                }

                // 加分销余额
                if ($order['commission1'] && $order['commission1_fee'] > 0) {
                    $user = Db::name('user')
                        ->where('id', $order['commission1'])
                        ->find();
                    if($user && $user['commission_level'] > 0) {
                        Db::name('user')
                            ->where('id', $user['id'])
                            ->update([
                                'commission_money' => $user['commission_money'] + $order['commission1_fee'],
                                'commission_total' => $user['commission_total'] + $order['commission1_fee'],
                            ]);
                        Db::name('commission_bill')
                            ->insert([
                                'site_id' => $user['site_id'],
                                'user_id' => $user['id'],
                                'order_id' => $order['id'],
                                'title' => '用户下单佣金（直推）',
                                'type' => 1,
                                'money' => $order['commission1_fee'],
                                'create_time' => time()
                            ]);
                    }
                }
                if ($order['commission2'] && $order['commission2_fee'] > 0) {
                    $user = Db::name('user')
                        ->where('id', $order['commission2'])
                        ->find();
                    if($user && $user['commission_level'] > 0) {
                        Db::name('user')
                            ->where('id', $user['id'])
                            ->update([
                                'commission_money' => $user['commission_money'] + $order['commission2_fee'],
                                'commission_total' => $user['commission_total'] + $order['commission2_fee'],
                            ]);
                        Db::name('commission_bill')
                            ->insert([
                                'site_id' => $user['site_id'],
                                'user_id' => $user['id'],
                                'order_id' => $order['id'],
                                'title' => '用户下单佣金（间推）',
                                'type' => 1,
                                'money' => $order['commission2_fee'],
                                'create_time' => time()
                            ]);
                    }
                }
                

                Db::commit();
            } catch (\Exception $e) {
                Db::rollback();
                saveLog($order['site_id'], $e->getMessage() . ' | ' . $xml);
                self::wxpayAnswer('FAIL', '支付失败');
            }

            self::wxpayAnswer('SUCCESS', 'OK');
        } else {
            self::wxpayAnswer('FAIL', '支付失败');
        }
    }

    private static function wxpayAnswer($code = 'SUCCESS', $msg = 'OK')
    {
        echo '<xml><return_code><![CDATA[' . $code . ']]></return_code><return_msg><![CDATA[' . $msg . ']]></return_msg></xml>';
        exit;
    }

    public function lxai()
    {
        $data = file_get_contents("php://input");
        // file_put_contents('./lxai.txt', $data);
        $data = json_decode($data, true);
        if ($data['action'] == 'IMAGINE') {
            $task_id = $data['id'];
            $draw = Db::name('msg_draw')
                ->where('task_id', $task_id)
                ->order('id desc')
                ->find();
            if (!$draw || $draw['state'] == 1) {
                exit;
            }

            if ($data['status'] == 'SUCCESS') {
                $lxaiSDK = new \ChatGPT\lxai();
                $images = $lxaiSDK->splitMjImage($data['imageUrl']);
                Db::name('msg_draw')
                    ->where('id', $draw['id'])
                    ->update([
                        'images' => implode('|', $images),
                        'state' => 1,
                        'finish_time' => time()
                    ]);
            } elseif ($data['status'] == 'IN_PROGRESS') {
                Db::name('msg_draw')
                    ->where('id', $draw['id'])
                    ->update([
                        'state' => 3,
                        'images' => $data['imageUrl'] ?? ''
                    ]);
            } elseif ($data['status'] == 'FAILURE' || $data['status'] == 'BANNED') {
                if ($data['status'] == 'BANNED') {
                    $errMsg = '图片含有敏感内容，生成中断';
                } elseif (!empty($data['failReason'])) {
                    $errMsg = $data['failReason'];
                } else {
                    $errMsg = '';
                }
                Db::name('msg_draw')
                    ->where('id', $draw['id'])
                    ->update([
                        'state' => 2,
                        'errmsg' => $errMsg,
                        'is_refund' => 1
                    ]);
                // 失败退费
                if (!$draw['is_refund']) {
                    changeUserDrawBalance($draw['user_id'], 1, '绘画失败退费');
                }
            }
        }

    }
    public function lxaitest()
    {
        $data = '{"action": "IMAGINE", "id": "3597868661", "prompt": "\u80a4\u767d\u8c8c\u7f8e\u5927\u957f\u817f", "promptEn": "", "description": "/imagine", "state": "option", "submitTime": "1687529401", "finishTime": null, "imageUrl": "https://mj.80w.top/attachments/1109766217520136214/1121804645464027258/brownmartin_3597868661White_skin_and_beautiful_long_legs_44160551-3e60-4ffc-bf73-cb68b309f9f8.png", "status": "SUCCESS"}';
        $data = json_decode($data, true);
        if ($data['action'] == 'IMAGINE') {
            $task_id = $data['id'];
            $draw = Db::name('msg_draw')
                ->where('task_id', $task_id)
                ->order('id desc')
                ->find();
            if (!$draw || $draw['state'] == 1) {
                exit;
            }

            if ($data['status'] == 'SUCCESS') {
                $lxaiSDK = new \ChatGPT\lxai();
                $images = $lxaiSDK->splitMjImage($data['imageUrl']);
                Db::name('msg_draw')
                    ->where('id', $draw['id'])
                    ->update([
                        'images' => implode('|', $images),
                        'state' => 1,
                        'finish_time' => time()
                    ]);
            } elseif ($data['status'] == 'IN_PROGRESS') {
                Db::name('msg_draw')
                    ->where('id', $draw['id'])
                    ->update([
                        'state' => 3,
                        'images' => $data['imageUrl'] ?? ''
                    ]);
            } elseif ($data['status'] == 'FAILURE' || $data['status'] == 'BANNED') {
                if ($data['status'] == 'BANNED') {
                    $errMsg = '图片含有敏感内容，生成中断';
                } elseif (!empty($data['failReason'])) {
                    $errMsg = $data['failReason'];
                } else {
                    $errMsg = '';
                }
                Db::name('msg_draw')
                    ->where('id', $draw['id'])
                    ->update([
                        'state' => 2,
                        'errmsg' => $errMsg,
                        'is_refund' => 1
                    ]);
                // 失败退费
                if (!$draw['is_refund']) {
                    changeUserDrawBalance($draw['user_id'], 1, '绘画失败退费');
                }
            }
        }
    }

    public function yijian()
    {
        $task = input('task', '', 'trim');
        $task = json_decode($task, true);
        $task_id = $task['Uuid'];
        $draw = Db::name('msg_draw')
            ->where([
                ['task_id', '=', $task_id]
            ])
            ->find();
        if (!$draw) {
            exit;
        }
        if (!empty($task['ImagePath'])) {
            $url = $this->saveToFile($task['ImagePath']);
            Db::name('msg_draw')
                ->where('id', $draw['id'])
                ->update([
                    'images' => $url,
                    'state' => 1,
                    'finish_time' => time()
                ]);
        }
    }

    public function yijian_test()
    {
        $task = '{"Uuid":"68197ecf-d350-49f9-9aa1-31b5eacc7f99","User":{"UserUuid":"3a81b0f4-b5dc-4ef4-a77a-eff5b44156c5","Name":"wdmzsytl","ApiKey":"daa49691a4f4712611d2285f0312fb5b","Phone":"15383730920","Role":0,"Score":26,"VipLevel":0,"TaskLimit":30,"Qps":10,"Money":0,"InvoicedMoney":0,"AccumulatedMoney":0,"Status":0,"Kind":1,"Operator":null,"CreateTime":"2023-05-25T09:16:56+08:00"},"CreateTime":"2023-06-22T23:33:30+08:00","UpdateTime":"2023-06-22T23:34:10+08:00","TextPrompt":"小美女5","RatioType":0,"QueueName":"unified_queue","Progress":100,"ImagePath":"https://yijian-painting-prod.cdn.bcebos.com/content/daa49691a4f4712611d2285f0312fb5b/68197ecf-d350-49f9-9aa1-31b5eacc7f99.jpg","ThumbImagePath":"https://yijian-painting-prod.cdn.bcebos.com/thumb_img/daa49691a4f4712611d2285f0312fb5b/68197ecf-d350-49f9-9aa1-31b5eacc7f99.jpg","Status":1,"Style":"\u003clora:taiwanDollLikeness_v10:0.3\u003e\u003clora:shojovibe_v11:0.3\u003e\u003clora:hanfu_v29:0.8\u003ehanfu, tang style outfits, tang hanfu, ","Steps":50,"Position":0,"PerTaskTime":0,"UseModel336":true,"FirstPosition":1,"ReportQueue":"report_queue_open_prod","Engine":"lora_cod_diffusion","GuidenceScale":7.5,"Score":1,"CallbackUrl":"https://ai.ttk.ink/api.php/notify/yijian","CallbackType":"end","UseObjectStorage":true,"CheckSafeMessage":"","EnableFaceEnhance":false,"IsLastLayerSkip":false,"Seed":0,"BaiduFilterImageId":"","InitImagePath":"","InitStrength":50,"Online":0}';
        $task = json_decode($task, true);
        $task_id = $task['Uuid'];
        $draw = Db::name('msg_draw')
            ->where([
                ['task_id', '=', $task_id]
            ])
            ->find();
        if (!$draw) {
            exit;
        }
        if (!empty($task['ImagePath'])) {
            $url = $this->saveToFile($task['ImagePath']);
            Db::name('msg_draw')
                ->where('id', $draw['id'])
                ->update([
                    'platform' => 'other',
                    'channel' => 'yijian',
                    'images' => $url,
                    'state' => 1,
                    'finish_time' => time()
                ]);
        }
    }

    private function saveToFile($content)
    {
        $context = stream_context_create([
            'http' => ['method' => 'GET', 'timeout' => 30],
            'ssl' => ['verify_peer' => false, 'verify_peer_name' => false]
        ]);
        $content = file_get_contents($content, false, $context);

        if (empty($content)) {
            return '';
        }
        // 保存到本地
        $date = date('Ymd');
        $dir = './upload/draw/' . $date . '/';
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        $filepath = $dir . uniqid() . '.png';
        file_put_contents($filepath, $content);
        if (!file_exists($filepath)) {
            return '';
        }
        $url = saveToOss($filepath);

        return $url;
    }
}
