<?php

namespace app\web\controller;

use ChatGPT\replicate;
use think\facade\Db;
use think\facade\Log;

class Draw extends Base
{
    /**
     * 获取消息历史记录
     */
    public function getHistoryMsg()
    {
        $platform = input('platform', '', 'trim');
        $channel = input('channel', '', 'trim');
        if (empty($platform)) {
            $drawSetting = getSystemSetting(self::$site_id, 'draw');
            $platform = $drawSetting['platform'] ?? '';
            $channel = $drawSetting['channel'] ?? '';
        }
        if (empty($platform) || empty($channel)) {
            return errorJson('参数错误：未知的通道');
        }

        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']],
            ['is_delete', '=', 0]
        ];
        if ($platform != 'other') {
            $where[] = ['platform', '=', $platform];
        } else {
            $where[] = ['channel', '=', $channel];
        }
        $list = Db::name('msg_draw')
            ->where($where)
            ->field('id,platform,channel,message,images,state,errmsg,create_time')
            ->order('id desc')
            ->limit(10)
            ->select()->toArray();
        $msgList = [];
        $list = array_reverse($list);
        foreach ($list as $v) {
            if ($v['state'] == 3) {
                if ($this->isMobile()) {
                    $v['state'] = 1;
                }
            }
            $msgList[] = [
                'draw_id' => $v['id'],
                'platform' => $v['platform'],
                'state' => $v['state'],
                'errmsg' => $v['errmsg'],
                'message' => $v['message'],
                'response' => explode('|', $v['images']),
                'create_time' => date('Y-m-d H:i:s', $v['create_time'])
            ];
        }

        return successJson($msgList);
    }

    /**
     * 提交绘画接口
     */
    public function draw()
    {
        try {
            #1、
            $user = Db::name('user')
                ->where('id', self::$user['id'])
                ->find();
            if (!$user) {
                $_SESSION['user'] = null;
                return errorJson('请登录');
            }
            // 判断禁言
            if ($user['is_freeze']) {
                return errorJson('系统繁忙，请稍后再试');
            }
            // 判断余额
            if (intval($user['balance_draw']) <= 0) {
                return errorJson('绘图次数用完了，请充值！');
            }
            // 判断并行任务
            $now = time();
            $taskNum = Db::name('msg_draw')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['state', '=', 0],
                    ['is_delete', '=', 0],
                    ['create_time', '>', $now - 600]
                ])
                ->count();
            if ($taskNum >= 5) {
                return errorJson('最多同时进行5个任务，请稍后再试');
            }

            #2、
            $draw_id = input('draw_id', 0, 'intval');
            if ($draw_id) {
                $info = Db::name('msg_draw')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $draw_id],
                        ['is_delete', '=', 0]
                    ])
                    ->find();
                if (!$info) {
                    return errorJson('没有找到记录，请刷新页面后重试');
                }
                $platform = $info['platform'];
                $channel = $info['channel'];
                $messageEn = $info['message_en'] ? $info['message_en'] : $info['message'];
                $clearMessage = $info['message'];
                $options = @json_decode($info['options'], true);
                // 状态重置
                Db::name('msg_draw')
                    ->where('id', $info['id'])
                    ->update([
                        'state' => $platform == 'mj' ? 0 : 3,
                        'images' => '',
                        'errmsg' => '',
                        'finish_time' => 0,
                        'create_time' => $now
                    ]);
            } else {
                $drawSetting = getSystemSetting(self::$site_id, 'draw');
                $platform = $drawSetting['platform'] ?? 'mj';
                $channel = $drawSetting['channel'] ?? 'lxai';
                if (empty($platform) || empty($channel)) {
                    return errorJson('参数错误：未知的通道');
                }

                $options = input('options', '', 'trim');
                if (empty($options)) {
                    $message = input('message', '', 'trim');

                    if ($platform == 'mj') {
                        $options = [
                            'ar' => '1:1',
                            'iw' => 1,
                            's' => 100,
                            'q' => 1,
                            'c' => 0,
                            'no' => '',
                            'seed' => '',
                            'niji' => '',
                            'style' => '',
                            'v' => '',
                            'tile' => 0,
                            'image' => ''
                        ];
                    } elseif ($platform == 'openai') {
                        $options = [
                            'size' => '1024x1024',
                            'quality' => 'standard',
                            'style' => 'natural'
                        ];
                    } elseif ($channel == 'yijian') {
                        $options = [
                            'engine' => 'default_dreamer_diffusion',
                            'style' => '',
                            'sub_style' => '',
                            'size' => 0,
                            'image' => ''
                        ];
                    }
                    $options['words'] = [['text' => $message, 'weight' => 1]];
                    $cate_id = 0;
                    $is_share = 0;
                } else {
                    $options = @json_decode($options, true);
                    $cate_id = input('cate_id', 0, 'intval');
                    $is_share = input('is_share', 1, 'intval');
                }

                if (empty($options['words'])) {
                    return errorJson('请输入画面描述');
                }

                $message = $this->makePrompt($platform, $options);
                $messageEn = $this->makePromptEn($platform, $options);
                $clearMessage = wordFilter($message);

                $draw_id = Db::name('msg_draw')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'user_id' => self::$user['id'],
                        'cate_id' => $cate_id,
                        'platform' => $platform,
                        'channel' => $channel,
                        'message' => $clearMessage,
                        'message_input' => $message === $clearMessage ? '' : $message,
                        'message_en' => $messageEn,
                        'state' => $platform == 'mj' ? 0 : 3, // 0未开始 1已生成 2生成失败 3生成中
                        'options' => json_encode($options),
                        'is_share' => $is_share ? 1 : 0,
                        'user_ip' => get_client_ip(),
                        'create_time' => $now
                    ]);
            }


            // DALL-E3
            if ($platform == 'openai') {
                $taskUrl = 'https://' . $_SERVER['HTTP_HOST'] . '/web.php/draw/submitOpenaiTask';
                $this->httpRequest($taskUrl, [
                    'draw_id' => $draw_id,
                    'message' => $messageEn,
                    'options' => $options
                ]);
                return successJson([
                    'draw_id' => $draw_id,
                    'message' => $clearMessage,
                    'create_time' => date('Y-m-d H:i:s', $now)
                ]);
            }

            $apikey = $this->getApiKey($channel);
            if (empty($apikey)) {
                return $this->setDrawFail($draw_id, 'key已用尽，请等待平台处理');
            }

            if ($platform == 'mj') {
                if ($channel == 'lxai') {
                    $notifyUrl = 'https://' . $_SERVER['HTTP_HOST'] . '/api.php/notify/lxai';
                    $lxaiSDK = new \ChatGPT\lxai($apikey);
                    $result = $lxaiSDK->drawMJ([
                        'prompt' => $messageEn,
                        'imageurl' => $options['image'] ?? '',
                        'notifyHook' => $notifyUrl
                    ]);
                    if ($result['errno']) {
                        return $this->setDrawFail($draw_id, $result['message']);
                    }
                    $task_id = $result['data'] ?? '';
                }
            } elseif ($platform == 'other') {
                if ($channel == 'yijian') {
                    $notifyUrl = 'https://' . $_SERVER['HTTP_HOST'] . '/api.php/notify/yijian';

                    $temp = explode('|', $apikey);
                    $apikey = $temp[0];
                    $apisecret = $temp[1] ?? '';
                    $yijianSDK = new \ChatGPT\yijian($apikey, $apisecret);
                    if (!empty($options['sub_style'])) {
                        $style = $options['sub_style'];
                    } elseif (!empty($options['style'])) {
                        $style = $options['style'];
                    } else {
                        $style = '';
                    }
                    $result = $yijianSDK->submitDrawTask([
                        'prompt' => $messageEn,
                        'ratio' => $options['size'] ?? 0,
                        'style' => $style,
                        'guidence_scale' => 7.5,
                        'engine' => $options['engine'] ?? 'default_dreamer_diffusion',
                        'callback_url' => $notifyUrl,
                        'init_image' => $options['image'] ?? ''
                    ]);
                    if ($result['errno']) {
                        return $this->setDrawFail($draw_id, $result['message']);
                    }
                    $task_id = $result['data']['Uuid'] ?? '';
                }
            }

            // 扣费
            changeUserDrawBalance(self::$user['id'], -1, '绘画消费');

            Db::name('msg_draw')
                ->where('id', $draw_id)
                ->update([
                    'task_id' => $task_id ?? ''
                ]);

            return successJson([
                'draw_id' => $draw_id,
                'message' => $clearMessage,
                'create_time' => date('Y-m-d H:i:s', $now)
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * 异步提交绘画任务
     * 仅供系统内部调用
     * 前端请勿使用此接口
     */
    public function submitOpenaiTask($draw_id = null)
    {
        ignore_user_abort();
        set_time_limit(300);
        $message = input('message', '', 'trim');
        $options = input('options', '');
        if (!$draw_id) {
            $draw_id = input('draw_id', '0', 'intval');
            if (!$draw_id) {
                exit;
            }
        }

        $user = Db::name('user')
            ->where('id', self::$user['id'])
            ->find();
        if (!$user) {
            return $this->setDrawFail($draw_id, '请重新登录');
        }

        $aiSetting = getAiSetting(self::$site_id, 'openai4');

        $keyType = $aiSetting['channel'] == 'api2d' ? 'api2d' : 'openai4';
        $apikey = $this->getApiKey($keyType);
        if (empty($apikey)) {
            return $this->setDrawFail($draw_id, 'key已用尽，请等待平台处理');
        }

        // 同步绘画方式
        $urls = [];
        $ChatGPT = new \ChatGPT\openai($apikey);
        $diyhost = $aiSetting['diyhost'];
        if ($diyhost == 'https://api.openai.com') {
            $apiSetting = getSystemSetting(0, 'api');
            if ($apiSetting['channel'] == 'agent' && $apiSetting['agent_host']) {
                $diyhost = rtrim($apiSetting['agent_host'], '/');
            }
        }
        $ChatGPT->setApiHost($diyhost);

        $result = $ChatGPT->draw([
            'prompt' => $message,
            'model' => 'dall-e-3',
            'size' => $options['size'] ?? '1024x1024',
            'style' => $options['style'] ?? 'natural',
            'quality' => $options['quality'] ?? 'standard',
            'n' => 1,
            'response_format' => 'b64_json'
        ]);
        if (empty($result)) {
            return $this->setDrawFail($draw_id, '未知错误');
        }

        if ($result['errno']) {
            $errMsg = $result['message'];
            if (strpos($errMsg, 'Billing hard limit has been reached') !== false || strpos($errMsg, 'Not enough point') !== false) {
                $errMsg = '接口余额不足';
                $this->setKeyStop($keyType, $apikey, $errMsg);
                $this->submitOpenaiTask($draw_id);
            } else {
                return $this->setDrawFail($draw_id, $errMsg);
            }
            exit;
        }

        foreach ($result['data'] as $img) {
            $url = '';
            if (!empty($img['b64_json'])) {
                $url = $this->saveToFile($img['b64_json']);
            } elseif (!empty($img['url'])) {
                $url = $this->saveToFile($img['url']);
            }
            if (!empty($url)) {
                $urls[] = $url;
            }
        }
        if (empty($urls)) {
            return $this->setDrawFail($draw_id, '生成图片失败');
        }

        // 扣费
        changeUserDrawBalance(self::$user['id'], -1, '绘画消费');

        // 生成成功，更新状态
        Db::name('msg_draw')
            ->where('id', $draw_id)
            ->update([
                'images' => implode('|', $urls),
                'state' => 1,
                'finish_time' => time()
            ]);
    }

    public function mjCtrl()
    {
        $draw_id = input('draw_id', 0, 'intval');
        $type = input('type', 'upscale', 'trim');
        $index = input('index', 1, 'intval');
        $draw = Db::name('msg_draw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $draw_id]
            ])
            ->find();
        if (!$draw) {
            return errorJson('参数错误');
        }
        if ($draw['state'] != 1) {
            return errorJson('请在绘图成功后操作');
        }
        if ($draw['platform'] != 'mj') {
            return errorJson('不支持的操作');
        }

        $message = $draw['message'] . ' -' . $type . $index;
        $message_input = !empty($draw['message_input']) ? $draw['message_input']. ' -' . $type . $index : '';
        $message_en = !empty($draw['message_en']) ? $draw['message_en'] . ' -' . $type . $index : '';
        $draw_id = Db::name('msg_draw')
            ->insertGetId([
                'site_id' => self::$site_id,
                'user_id' => self::$user['id'],
                'cate_id' => $draw['cate_id'],
                'platform' => $draw['platform'],
                'channel' => $draw['channel'],
                'message' => $message,
                'message_input' => $message_input,
                'message_en' => $message_en,
                'options' => $draw['options'],
                'state' => 0, // 0生成中 1已生成 2生成失败
                'is_share' => 0,
                'user_ip' => get_client_ip(),
                'create_time' => time()
            ]);

        $apikey = $this->getApiKey($draw['channel']);
        $notifyUrl = 'https://' . $_SERVER['HTTP_HOST'] . '/api.php/notify/lxai';
        $lxaiSDK = new \ChatGPT\lxai($apikey);
        $result = $lxaiSDK->mjCtrl([
            'id' => $draw['task_id'],
            'type' => $type,
            'index' => $index,
            'notifyHook' => $notifyUrl
        ]);
        if ($result['errno']) {
            return $this->setDrawFail($draw_id, $result['message']);
        }

        $task_id = $result['data'] ?? '';
        Db::name('msg_draw')
            ->where('id', $draw_id)
            ->update([
                'task_id' => $task_id
            ]);

        // 扣费
        changeUserDrawBalance(self::$user['id'], -1, '绘画消费');

        return successJson([
            'draw_id' => $draw_id,
            'message' => $message
        ]);
    }

    /**
     * 供前端轮询绘画结果
     */
    public function getDrawResult()
    {
        $draw_id = input('draw_id', 0, 'intval');
        $draw = Db::name('msg_draw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $draw_id],
                ['is_delete', '=', 0]
            ])
            ->find();
        if (!$draw) {
            // 未找到任务
            return successJson([
                'state' => -1
            ]);
        }
        if ($draw['state'] == 0 || $draw['state'] == 3) {
            $now = time();
            if ($now - $draw['create_time'] > 600) {
                $errMsg = text('图片生成失败');
                // 生成超时退费
                changeUserDrawBalance(self::$user['id'], 1, '绘画失败退费');
                $this->setDrawFail($draw_id, $errMsg);
                return successJson([
                    'state' => 2,
                    'message' => $errMsg
                ]);
            }
            if ($draw['state'] == 0) {
                return successJson([
                    'state' => 0
                ]);
            } else {
                return successJson([
                    'state' => $this->isMobile() ? 0 : 3,
                    'image' => $draw['images']
                ]);
            }

        } elseif ($draw['state'] == 1) {
            return successJson([
                'state' => 1,
                'images' => explode('|', $draw['images'])
            ]);
        } elseif ($draw['state'] == 2) {
            return successJson([
                'state' => 2,
                'message' => $draw['errmsg']
            ]);
        } else {
            // 未知状态
            return successJson([
                'state' => -1
            ]);
        }
    }

    public function getDrawOptions()
    {
        $draw_id = input('draw_id', 0, 'intval');
        $info = Db::name('msg_draw')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $draw_id],
                ['is_delete', '=', 0]
            ])
            ->find();
        if (!$info) {
            return errorJson('没有找到记录，请刷新页面后重试');
        }
        $options = [];
        if(!empty($info['options'])) {
            $options = json_decode($info['options'], true);
        } else {
            $options = [
                'words' => [['text' => $info['message'], 'weight' => 1]]
            ];
        }
        return successJson([
            'cate_id' => $info['cate_id'],
            'is_share' => $info['is_share'],
            'options' => $options
        ]);
    }

    private function setDrawFail($draw_id, $errMsg)
    {
        Db::name('msg_draw')
            ->where('id', $draw_id)
            ->update([
                'state' => 2,
                'errmsg' => $errMsg,
                'is_refund' => 1
            ]);
        return null;
    }

    /**
     * 保存图片文件内容到本地或者云存储
     */
    private function saveToFile($content)
    {
        if (strpos($content, 'https://') !== false || strpos($content, 'http://') !== false) {
            $context = stream_context_create([
                'http' => ['method' => 'GET', 'timeout' => 30],
                'ssl' => ['verify_peer' => false, 'verify_peer_name' => false]
            ]);
            $content = file_get_contents($content, false, $context);
        } else {
            $content = base64_decode($content);
        }
        if (empty($content)) {
            return '';
        }
        // 保存到本地
        $date = date('Ymd');
        $dir = './upload/draw/' . $date . '/';
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        $filepath = $dir . self::$user['id'] . uniqid() . '.png';
        file_put_contents($filepath, $content);
        if (!file_exists($filepath)) {
            return '';
        }
        $url = saveToOss($filepath);

        return $url;
    }

    /**
     * 从key池里取回一个key
     */
    private function getApiKey($type)
    {

        $rs = Db::name('keys')
            ->where([
                ['site_id', '=', self::$site_id],
                ['type', '=', $type],
                ['state', '=', 1]
            ])
            ->order('last_time asc, id asc')
            ->find();
        if (!$rs) {
            return '';
        }
        Db::name('keys')
            ->where('id', $rs['id'])
            ->update([
                'last_time' => time()
            ]);
        return $rs['key'];
    }

    private function setKeyStop($type, $key, $errorMsg)
    {
        if ($errorMsg) {
            Db::name('keys')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['type', '=', $type],
                    ['key', '=', $key]
                ])
                ->update([
                    'state' => 0,
                    'stop_reason' => $errorMsg
                ]);
        }
    }

    private function httpRequest($url, $post = null)
    {
        $token = session_id();
        $header = [
            'Content-Type: application/json',
            'x-token: ' . $token ?? ''
        ];
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_TIMEOUT_MS, 5000);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post));
        }
        curl_exec($ch);
        curl_close($ch);
    }

    public function getDrawSetting()
    {
        $drawSetting = getSystemSetting(self::$site_id, 'draw');
        $drawIsOpen = isset($drawSetting['is_open']) ? intval($drawSetting['is_open']) : 1;
        if (!$drawIsOpen) {
            return errorJson('绘画功能已停止使用');
        }
        $setting = [
            'platform' => $drawSetting['platform'] ?? 'mj',
            'channel' => $drawSetting['channel'] ?? 'lxai'
        ];
        if ($drawSetting['channel'] == 'yijian') {
            $options = json_decode('{"imageSizes":[{"text":"4:3","value":0,"desc":"1200x900"},{"text":"3:4","value":1,"desc":"900x1200"},{"text":"1:1","value":2,"desc":"1024x1024"},{"text":"16:9","value":3,"desc":"1280x720"},{"text":"9:16","value":4,"desc":"720x1280"}],"stableArtists":[{"id":"0","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"不限定","value":""},{"id":"1","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/msr_xjr.png","text":"马塞尔·夏加尔","value":"MarcelChagall"},{"id":"2","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/csl.png","text":"村上隆","value":"TakashiMurakami"},{"id":"3","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/mx.png","text":"穆夏","value":"AlphonseMucha"},{"id":"4","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bjs.png","text":"毕加索","value":"PabloPicasso"},{"id":"5","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/fg.png","text":"梵高","value":"VincentvanGogh"},{"id":"6","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/nm.png","text":"莫奈","value":"ClaudeMonet"},{"id":"7","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bl_ss.png","text":"保罗·塞尚","value":"PaulCezanne"},{"id":"8","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/tms_kr.png","text":"托马斯·科尔","value":"ThomasCole"},{"id":"9","img_words":"","poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/mbws.png","text":"莫比乌斯","value":"Moebius"}],"styleDetails":[{"GroupName":"通用设计","Styles":[{"default_guide_scale":7.5,"engine":"default_dreamer_diffusion","group_name":"通用设计","id":"103","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/ZN.png","sub_styles":[],"text":"智能","value":""},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"0","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","sub_styles":[],"text":"不限定","value":""},{"default_guide_scale":7.5,"engine":"vinteprotogenmixV10_diffusion","group_name":"通用设计","id":"24","img_words":"新","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/lbxzs.png","sub_styles":[],"text":"六边形战士","value":""},{"default_guide_scale":7.5,"engine":"mid_stable_diffusion","group_name":"通用设计","id":"3","img_words":"热","is_color_enhance":true,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/ysgqh.png","sub_styles":[],"text":"艺术感强化","value":""},{"default_guide_scale":7.5,"engine":"redshift_novelai_sd_merge_diffusion","group_name":"通用设计","id":"4","img_words":"新","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/3d_jmfg.png","sub_styles":[],"text":"3D建模风格","value":""},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"7","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/yh.png","sub_styles":[],"text":"油画","value":" very detailed oil painting, oil on canvas"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"8","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/xhyq.png","sub_styles":[],"text":"虚幻引擎渲染","value":" unreal engine render, 8k"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"9","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/qbsm.png","sub_styles":[],"text":"铅笔素描","value":" milt kahl pencil sketch"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"10","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/schh.png","sub_styles":[],"text":"水彩绘画","value":" in watercolor gouache detailed paintings, insanely detail"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"11","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/1950nd.png","sub_styles":[],"text":"1950年代纸浆科幻封面","value":" style of 1950s pulp sci-fi cover"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"12","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/xhc.png","sub_styles":[],"text":"新海诚","value":" by makoto shinkai"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"13","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/Victo_Ngai.png","sub_styles":[],"text":"倪传婧","value":" by victo ngai"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"14","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/xsh.png","sub_styles":[],"text":"像素画","value":" 64-bit pixel art"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"15","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/zgf.png","sub_styles":[],"text":"中国画","value":" chinese ink-wash painting style"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"16","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/sbpk.png","sub_styles":[],"text":"赛博朋克","value":" hyper realistic cyberpunk style"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"17","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/jpl.png","sub_styles":[],"text":"吉卜力","value":" artwork by studio ghibli, lighting, clear focus, very coherent, high detailed"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"18","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/zqb.png","sub_styles":[],"text":"蒸汽波","value":" vaporwave arcade, 4k, ultra realistic, award winning photograph"},{"default_guide_scale":7.5,"engine":"stable_diffusion","group_name":"通用设计","id":"19","img_words":"","is_color_enhance":false,"is_need_artists":true,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/yxzy.png","sub_styles":[],"text":"印象主义","value":" in claude monet style"}],"ShowImage":"https://app.yjai.art:30108/ai-painting-control/type_style1.jpg"},{"GroupName":"动漫设计","Styles":[{"default_guide_scale":11,"engine":"anything4_diffusion","group_name":"动漫设计","id":"20","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/newdmbeta.png","sub_styles":[{"group_name":"动漫设计","id":4,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"动漫设计","id":5,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/dmxg.png","text":"动漫线稿","value":"<lora:animeLineartStyle_v20Offset:1>"},{"group_name":"动漫设计","id":6,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/gachanh.png","text":"gacha女孩","value":"<lora:gachaSplashLORA_gachaSplashFarShot:0.9>"},{"group_name":"动漫设计","id":7,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/xhc.png","text":"新海诚","value":"<lora:makotoShinkaiSubstyles_offset:1>"},{"group_name":"动漫设计","id":11,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/fc.png","text":"沁彩","value":"<lora:Colorwater_v4:0.9>"},{"group_name":"动漫设计","id":12,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/jpl.png","text":"吉卜力","value":"<lora:studioGhibliStyle_offset:1>"},{"group_name":"动漫设计","id":13,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/Qban.png","text":"Q版","value":"<lora:maplestoryStyle_v20:0.8>"},{"group_name":"动漫设计","id":14,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/kap.png","text":"可爱屁","value":"<lora:cutescrap05v_cutescrap3:0.8>"},{"group_name":"动漫设计","id":19,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/tlp.png","text":"塔罗牌","value":"<lora:animeTarotCardArtStyleLora_v20Offset:0.8>"},{"group_name":"动漫设计","id":20,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/nygy.png","text":"暗夜光影","value":"<lora:lightAndShadow_v10:0.8>"},{"group_name":"动漫设计","id":21,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/sygy.png","text":"实用光影","value":"<lora:sunAndShadow_v10:0.8>"},{"group_name":"动漫设计","id":22,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/90ndf.png","text":"90年代风","value":"<lora:1990sAnimeStyleLora_1:0.6>"},{"group_name":"动漫设计","id":23,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/cxtmh.png","text":"粗线条漫画","value":"<lora:thickerLinesAnimeStyle_loraVersion:1>"},{"group_name":"动漫设计","id":28,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/xrs.png","text":"小人书","value":"<lora:Xiaorenshu_v10:0.9>"},{"group_name":"动漫设计","id":29,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/zgf.png","text":"中国风","value":"<lora:loraGuofeng2Lora_v20Lora:0.8>"},{"group_name":"动漫设计","id":50,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/jjdm.png","text":"极简动漫","value":"<lora:minimalistAnimeStyle_v10:0.9>"},{"group_name":"动漫设计","id":53,"parent_id":20,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/cmsn.png","text":"彩墨少女","value":"<lora:quicksketch_v1:1>"}],"text":"新动漫beta","value":""},{"default_guide_scale":11,"engine":"counterfeit_diffusion","group_name":"动漫设计","id":"28","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/qxdm.png","sub_styles":[{"group_name":"动漫设计","id":31,"parent_id":28,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"动漫设计","id":32,"parent_id":28,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/shouban.png","text":"手办","value":"<lora:figmaAnimeFigures_figma:1>"},{"group_name":"动漫设计","id":42,"parent_id":28,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/qxt.png","text":"轻线条","value":"<lora:lightlineArtLora_v10:0.6>"},{"group_name":"动漫设计","id":49,"parent_id":28,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/gachanh.png","text":"gacha女孩","value":"<lora:gachaSplashLORA_gachaSplashFarShot:0.9>"},{"group_name":"动漫设计","id":58,"parent_id":28,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/gcgx.png","text":"古色古香","value":"<lora:miaobishenghua_v10:1>"}],"text":"清新动漫","value":""},{"default_guide_scale":7.5,"engine":"best_colorful_diffusion","group_name":"动漫设计","id":"100","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/fcdm2.png","sub_styles":[{"group_name":"动漫设计","id":106,"parent_id":100,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"动漫设计","id":107,"parent_id":100,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/fzmh.png","text":"纷争盲盒","value":"<lora:blindbox_V1Mix:1>"},{"group_name":"动漫设计","id":110,"parent_id":100,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/minisj.png","text":"迷你世界","value":"<lora:miniatureV1:0.8>"},{"group_name":"动漫设计","id":113,"parent_id":100,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/gdmh.png","text":"高达盲盒","value":"<lora:blindbox_V1Mix:1><lora:gundamRX782OutfitStyle_v10:0.4>"}],"text":"瑞士军刀","value":""},{"default_guide_scale":11,"engine":"acgn_diffusion","group_name":"动漫设计","id":"1","img_words":"热","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/jddm.png","sub_styles":[],"text":"经典动漫","value":""},{"default_guide_scale":7.5,"engine":"anygen_diffusion","group_name":"动漫设计","id":"21","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/2_5Ddm.png","sub_styles":[],"text":"2.5D动漫","value":""},{"default_guide_scale":7.5,"engine":"protothing_diffusion","group_name":"动漫设计","id":"22","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/ecych.png","sub_styles":[],"text":"二次元插画","value":""},{"default_guide_scale":7.5,"engine":"colorfulcocktail_diffusion","group_name":"动漫设计","id":"23","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/ecysc.png","sub_styles":[],"text":"二次元色彩","value":""},{"default_guide_scale":7.5,"engine":"dalcefo_diffusion","group_name":"动漫设计","id":"27","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/ptdm.png","sub_styles":[],"text":"平涂动漫","value":""},{"default_guide_scale":7.5,"engine":"flat_anime_diffusion","group_name":"动漫设计","id":"101","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/ptdm2.png","sub_styles":[{"group_name":"动漫设计","id":111,"parent_id":101,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"动漫设计","id":112,"parent_id":101,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/dancai.png","text":"淡彩","value":"<lora:LohaWhiteDewStyle_lohaV10:1>"}],"text":"平涂动漫2","value":""},{"default_guide_scale":7.5,"engine":"old_cos_diffusion","group_name":"动漫设计","id":"29","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/gzdm.png","sub_styles":[],"text":"古早动漫","value":""},{"default_guide_scale":7.5,"engine":"colorful_diffusion","group_name":"动漫设计","id":"30","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/fcdm.png","sub_styles":[],"text":"彩粉动漫","value":""},{"default_guide_scale":7.5,"engine":"meina_diffusion","group_name":"动漫设计","id":"32","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/2Dxs.png","sub_styles":[],"text":"2D写实","value":""},{"default_guide_scale":7.5,"engine":"meiman_diffusion","group_name":"动漫设计","id":"102","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type2/omdm.png","sub_styles":[],"text":"欧美动漫","value":""}],"ShowImage":"https://app.yjai.art:30108/ai-painting-control/type_style2.jpg"},{"GroupName":"现实设计","Styles":[{"default_guide_scale":7.5,"engine":"Gf_style2_diffusion","group_name":"现实设计","id":"26","img_words":"新","is_color_enhance":false,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/guofeng.png","sub_styles":[{"group_name":"现实设计","id":15,"parent_id":26,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"现实设计","id":16,"parent_id":26,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/csmb.png","text":"彩色水墨","value":"<lora:Moxin_10:0.8>"},{"group_name":"现实设计","id":17,"parent_id":26,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/lbsm.png","text":"留白水墨","value":"<lora:Moxin_Shukezouma11:0.7><lora:Moxin_10:0.8>"},{"group_name":"现实设计","id":24,"parent_id":26,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/sgf.png","text":"三国风","value":"<lora:Sanguo_v099:1>"}],"text":"国风","value":""},{"default_guide_scale":7.5,"engine":"lora_cod_diffusion","group_name":"现实设计","id":"6","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/Doll.png","sub_styles":[{"group_name":"现实设计","id":0,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"现实设计","id":1,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanxi1.png","text":"韩系女生","value":"<lora:koreanDollLikeness_v10:0.66>"},{"group_name":"现实设计","id":2,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/xiaoriben.png","text":"日系女生","value":"<lora:japaneseDollLikeness_v10:0.66>"},{"group_name":"现实设计","id":8,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanfu.png","text":"汉服风","value":"<lora:hanfu_v28:1><lora:shojovibe_v11:0.6>"},{"group_name":"现实设计","id":54,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanfu_s.png","text":"汉服风(宋)","value":"<lora:taiwanDollLikeness_v10:0.3><lora:shojovibe_v11:0.3><lora:hanfu_v29:0.8>hanfu, song style outfits, song hanfu, "},{"group_name":"现实设计","id":55,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanfu_t.png","text":"汉服风(唐)","value":"<lora:taiwanDollLikeness_v10:0.3><lora:shojovibe_v11:0.3><lora:hanfu_v29:0.8>hanfu, tang style outfits, tang hanfu, "},{"group_name":"现实设计","id":56,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanfu_m.png","text":"汉服风(明)","value":"<lora:taiwanDollLikeness_v10:0.3><lora:shojovibe_v11:0.3><lora:hanfu_v29:0.8>hanfu, ming style outfits, ming hanfu, "},{"group_name":"现实设计","id":57,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanfu_h.png","text":"汉服风(汉)","value":"<lora:taiwanDollLikeness_v10:0.3><lora:shojovibe_v11:0.3><lora:hanfu_v29:0.8>hanfu, han style outfits, han hanfu, "},{"group_name":"现实设计","id":9,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/ssns.png","text":"时尚女生","value":"<lora:fashionGirl_v50:0.6>"},{"group_name":"现实设计","id":10,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/kanh.png","text":"可爱女生","value":"<lora:cuteGirlMix4_v10:0.5>"},{"group_name":"现实设计","id":51,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/mhsn.png","text":"梦幻少女","value":"<lora:dreamyGirlsFace_dreamyFace:0.6>"},{"group_name":"现实设计","id":26,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/qbq.png","text":"铅笔裙","value":"<lora:hauteCouturePencil_v10:0.7><lora:koreanDollLikeness_v15:0.3>"},{"group_name":"现实设计","id":27,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/qipao.png","text":"旗袍","value":"<lora:qipao_8:0.6><lora:zhouzhou_zsyV10:0.4><lora:koreanDollLikeness_v15:0.4>"},{"group_name":"现实设计","id":30,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/guofengnh.png","text":"国风","value":"<lora:loraGuofeng2Lora_v20Lora:1.6>"},{"group_name":"现实设计","id":47,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/zzsn.png","text":"正装少女","value":"<lora:recruitSuit_recsuitVer:1><lora:cuteGirlMix4_v10:0.4>"},{"group_name":"现实设计","id":59,"parent_id":6,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/lfxn.png","text":"礼服新娘","value":"<lora:chineseGirlsInWeddingDressOrHakamaOrHanfuInMarvellousScene_v01:0.9>"}],"text":"Doll模型","value":""},{"default_guide_scale":7.5,"engine":"lucky_real_diffusion","group_name":"现实设计","id":"31","img_words":"新","is_color_enhance":false,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/xDoll.png","sub_styles":[{"group_name":"现实设计","id":33,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png","text":"默认","value":""},{"group_name":"现实设计","id":43,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/hanxi1.png","text":"韩系女生","value":"<lora:koreanDollLikeness_v10:0.66>"},{"group_name":"现实设计","id":45,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/xiaoriben.png","text":"日系女生","value":"<lora:japaneseDollLikeness_v10:0.66>"},{"group_name":"现实设计","id":35,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/ssns.png","text":"时尚女生","value":"<lora:fashionGirl_v50:0.5>"},{"group_name":"现实设计","id":36,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/xcns.png","text":"乡村女生","value":"<lora:villageGirlCungu_v12:0.6>"},{"group_name":"现实设计","id":37,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/qznh.png","text":"气质女生","value":"<lora:aiBeautyIthlinni_ithlinniV1:0.5>"},{"group_name":"现实设计","id":38,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/kanh.png","text":"可爱女生","value":"<lora:cuteGirlMix4_v10:0.5>"},{"group_name":"现实设计","id":39,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/jznh.png","text":"精致女生","value":"<lora:tifosemix_v1064s:0.6>"},{"group_name":"现实设计","id":40,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/mlsn.png","text":"美丽少女","value":"<lora:shojovibe_v11:0.6>"},{"group_name":"现实设计","id":46,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/zzsn.png","text":"正装少女","value":"<lora:recruitSuit_recsuitVer:1><lora:shojovibe_v11:0.7>"},{"group_name":"现实设计","id":52,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/mhsn.png","text":"梦幻少女","value":"<lora:dreamyGirlsFace_dreamyFace:0.6>"},{"group_name":"现实设计","id":48,"parent_id":31,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/qbq.png","text":"铅笔裙","value":"<lora:hauteCouturePencil_v10:0.7><lora:koreanDollLikeness_v15:0.3>"}],"text":"新Doll模型","value":""},{"default_guide_scale":7.5,"engine":"goodAsianGirlFaceV10_diffusion","group_name":"现实设计","id":"25","img_words":"新","is_color_enhance":true,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/zsrx.png","sub_styles":[],"text":"真实人像","value":""},{"default_guide_scale":7.5,"engine":"photoreal_engine","group_name":"现实设计","id":"5","img_words":"新","is_color_enhance":false,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/zsgzp.png","sub_styles":[],"text":"真实感照片","value":""},{"default_guide_scale":7.5,"engine":"pvc_diffusion","group_name":"现实设计","id":"104","img_words":"新","is_color_enhance":false,"is_need_artists":false,"poster":"https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type3/shouban.png","sub_styles":[],"text":"手办","value":""}],"ShowImage":"https://app.yjai.art:30108/ai-painting-control/type_style3.jpg"}],"systemPrompts":[{"artist_id":"0","engine_id":"3","text":"水晶球城堡","value":"水晶球里的彩色魔法城堡"},{"artist_id":"0","engine_id":"2","text":"美貌少年","value":"顶级打光, 仙境, 云朵, 飞鸟, boy, 少年, 正太, 可爱的脸, 金色瞳孔, 白色短发, 华丽的耳钉, 面无表情, 最高画质, 大师之作, 杰作, 惊艳, 美貌, 凌乱的发丝, 大师之作, 细致的脸部描写, 扑克牌, 美人痣, 异色瞳"},{"artist_id":"0","engine_id":"3","text":"壮丽的树","value":"Magnificent tree,seen from a distance,science fiction,Holy terror,mystery,fantasy,sense of technology,unreal engine,metallic texture,Volume light,Look up,colorful,Super wide angle,magnificent,great spectacle,by Raphael Lacoste"},{"artist_id":"0","engine_id":"3","text":"半机械马","value":"Realistic portrait beautiful detailed matte painting of  cinematic movie scene jet li mutate into cyborg  horse. horror, created by gustave dore and greg  rutkowski, high detailed, smooth draw, synthwave  neon retro, intricate, realistic proportions, dramatic  lighting, trending on artstation."},{"artist_id":"5","engine_id":"0","text":"星空","value":"星空"},{"artist_id":"0","engine_id":"4","text":"蓝色人种","value":"Portrait of a blue skin genasi with a square jaw from d & d by greg rutkowski, dreadlocks and small beard, tempest priest, runic rings, d & d character, blue, black background, highly detailed portrait, digital painting, artstation, concept art, smooth, sharp foccus ilustration, artstation hq"},{"artist_id":"0","engine_id":"4","text":"小兔子","value":"Portrait of a super cute bunny, a carrot, pixar, zootopia, cgi, blade runner. trending on artstation"},{"artist_id":"0","engine_id":"4","text":"星际狐狸","value":"Underwater steampunk biopunk portrait of fox mccloud from star fox ( 1 9 9 3 ), hyper detailed, digital art, trending in artstation, cinematic lighting, studio quality, smooth render, unreal engine 5 rendered, octane rendered, art style by klimt and nixeu and ian sprigger and wlop and krenz cushart."},{"artist_id":"0","engine_id":"3","text":"雄狮","value":"A male anthro muscular albino lion\'s face breaching through a wall of water, headshot, water sprites, splashing, deep blue ocean, highly detailed, realistic digital art, trending on artstation, character design by charlie bowater, ross tran, artgerm, and makoto shinkai, detailed, inked, western comic book art, 2021 award winning painting"},{"artist_id":"0","engine_id":"16","text":"月下独舞","value":"An emotional concept painting of a cyberpunk  android dancing in the moonlight, neon signs, empty  city, large detailed moon, concept painting by  raymond swanland and ruan jia and greg rutkowski"},{"artist_id":"0","engine_id":"0","text":"寺庙&云彩","value":"Overlooking brilliant temples,journey to the west,lakes,clouds and sun,fairy tales,light effects,fantasy,SAMUEL BEAL,abhimanyu bhadauria,artstation,colorful"},{"artist_id":"0","engine_id":"3","text":"老骑士","value":"Portrait of an old knight with a large moustache, male, detailed face, fantasy, highly detailed, cinematic lighting, digital art painting by greg rutkowski"},{"artist_id":"0","engine_id":"0","text":"中国城堡&桃花树","value":"A beautiful painting of Chinese fairyland full of peach blossom trees and Chinese castles, cloudy and foggy by Makoto Shinkai"},{"artist_id":"0","engine_id":"2","text":"未来古城","value":"Evil robot attacking feudal japan city, moody sky, dramatic lighting, painted by james jean and wayne barlowe and moebius, high details, cinematic, denoised, octane render, fog, spooky, cgsociety 8k"},{"artist_id":"0","engine_id":"3","text":"动画都市","value":"A japanese city near the sea, lofi, dreamy, moody, very colorful, anime inspiration, makoto shinkai, ghibli vibe"},{"artist_id":"0","engine_id":"16","text":"赛博朋克都市","value":"Very detailed masterpiece painting of a busy  cyberpunk city street, portrait, artstation, concept art  by greg rutkowski"},{"artist_id":"0","engine_id":"3","text":"灰狼肖像","value":"Portrait of a gray wolf, wolf face, intricate, elegant,  highly detailed, digital painting, artstation, concept  art, smooth, sharp focus, illustration, art by krenz  cushart and artem demura and alphonse mucha"},{"artist_id":"0","engine_id":"2","text":"大教堂","value":"arch,architecture,book_stack,bookshelf,building,candle,chandelier,city,city_lights,cityscape,copyright_name,fire,indoors,library,lantern,skyscraper,standing,sunset,clock,gears,butterfly,window,cinematic, epic composition,no_humans,scenery,detailed, atmospheric, artstation trending"},{"artist_id":"0","engine_id":"2","text":"海底世界","value":"A beautiful matte digital painting of a light-green sea turtle swimming over an red-orange coral reef through blue-violet waters, triadic color palette, painted in the style of national geographic, trending on artstation hq"},{"artist_id":"0","engine_id":"2","text":"故乡的原野","value":"Anime screenshot wide-shot landscape with house in the apple garden, beautiful ambiance, golden hour, studio ghibli style, by hayao miyazaki, highly detailed"}]}');
        } else {
            $options = [];
        }

        $setting['options'] = $options;
        return successJson($setting);
    }

    public function getWordsCate()
    {
        $list = Db::name('draw_words_cate')
            ->where([
                ['pid', '=', 0],
                ['is_delete', '=', 0]
            ])
            ->field('id, title')
            ->order('weight desc, id asc')
            ->select()->each(function($item) {
                $item['children'] = Db::name('draw_words_cate')
                    ->where([
                        ['pid', '=', $item['id']],
                        ['is_delete', '=', 0]
                    ])
                    ->field('id, title')
                    ->order('weight desc, id asc')
                    ->select()->toArray();
                return $item;
            });
        return successJson($list);
    }

    public function getWordsList()
    {
        $pcate = input('pcate', 0, 'intval');
        $scate = input('scate', 0, 'intval');
        $where = [
            ['pcate', '=', $pcate],
            ['is_delete', '=', 0]
        ];
        if ($scate) {
            $where[] = ['scate', '=', $scate];
        }
        $list = Db::name('draw_words')
            ->where($where)
            ->field('id,pcate,scate,title,desc,thumb')
            ->order('weight desc, id asc')
            ->select()->toArray();
        $count = Db::name('draw_words')
            ->where($where)
            ->count();
        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    public function getDrawCate()
    {
        $list = Db::name('draw_cate')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1],
                ['is_delete', '=', 0]
            ])
            ->field('id, title')
            ->order('weight desc, id asc')
            ->select()->toArray();
        return successJson($list);
    }

    /**
     * 生成提示词
     */
    private function makePrompt($platform, $options)
    {
        $prompt = '';
        if ($platform == 'mj') {
            foreach ($options['words'] as $word) {
                $prompt .= $word['text'];
                if ($word['weight'] != 1) {
                    $prompt .= ' ::' . $word['weight'];
                }
                $prompt .= '，';
            }
            $prompt = mb_substr($prompt, 0, -1);
            $cmd = $this->makeMjCmd($options);
            $prompt .= $cmd;
        } else {
            foreach ($options['words'] as $word) {
                $prompt .= $word['text'];
                $prompt .= '，';
            }
            $prompt = mb_substr($prompt, 0, -1);
        }

        return $prompt;
    }

    /**
     * 生成英文提示词
     */
    private function makePromptEn($platform, $options)
    {
        $prompt = '';
        if ($platform == 'mj') {
            foreach ($options['words'] as $word) {
                $entitle = Db::name('draw_words')
                    ->where('title', $word['text'])
                    ->value('entitle');
                if ($entitle) {
                    $prompt .= $entitle;
                    Db::name('draw_words')
                        ->where('title', $word['text'])
                        ->inc('used')
                        ->update();
                } else {
                    $prompt .= $word['text'];
                }
                if ($word['weight'] != 1) {
                    $prompt .= ' ::' . $word['weight'];
                }
                $prompt .= ',';
            }
            $prompt = mb_substr($prompt, 0, -1);
            if (!empty($options['no'])) {
                $prompt .= ' --no ' . $options['no'];
            }
            $prompt = wordFilter($prompt);
            $prompt = translate(self::$site_id, $prompt);
            $cmd = $this->makeMjCmd($options);
            $prompt .= $cmd;
        } else {
            foreach ($options['words'] as $word) {
                $prompt .= $word['text'];
                $prompt .= ',';
            }
            $prompt = rtrim($prompt, ',');
            $prompt = wordFilter($prompt);
            $prompt = translate(self::$site_id, $prompt);
        }

        return $prompt;
    }

    /**
     * MJ指令拼成字符串
     */
    private function makeMjCmd($options)
    {
        $cmd = '';
        if (isset($options['ar']) && $options['ar'] != '1:1') {
            $cmd .= ' --ar ' . $options['ar'];
        }
        if (isset($options['iw']) && $options['iw'] != 1) {
            $cmd .= ' --iw ' . $options['iw'];
        }
        if (isset($options['q']) && $options['q'] != 1) {
            $cmd .= ' --q ' . $options['q'];
        }
        if (isset($options['s']) && $options['s'] != 100) {
            $cmd .= ' --s ' . $options['s'];
        }
        if (isset($options['c']) && $options['c'] != 0) {
            $cmd .= ' --c ' . $options['c'];
        }
        if (!empty($options['seed'])) {
            $cmd .= ' --seed ' . $options['seed'];
        }
        if (!empty($options['niji'])) {
            $cmd .= ' --niji ' . $options['niji'];
        }
        if (!empty($options['style'])) {
            $cmd .= ' --style ' . $options['style'];
        }
        if (!empty($options['v'])) {
            $cmd .= ' --v ' . $options['v'];
        }
        if (!empty($options['tile'])) {
            $cmd .= ' --tile';
        }
        return $cmd;
    }

    /**
     * @return Boolean
     * 临时兼容手机端state=3的问题
     */
    private function isMobile()
    {
        $userAgent = strtolower($_SERVER['HTTP_USER_AGENT']);
        if (strpos($userAgent, 'miniprogram') !== false || strpos($userAgent, 'micromessenger') !== false) {
            return true;
        }
        return false;
    }
}
