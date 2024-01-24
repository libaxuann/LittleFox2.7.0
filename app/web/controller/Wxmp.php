<?php

namespace app\web\controller;

use think\facade\Db;

class Wxmp
{
    private static $site_id = 1;
    private static $wxmpSetting = [];

    public function server()
    {
        self::$site_id = input('site', 1, 'intval');
        self::$wxmpSetting = getSystemSetting(self::$site_id, 'wxmp');
        $config = [
            'app_id' => self::$wxmpSetting['appid'] ?? '',
            'secret' => self::$wxmpSetting['appsecret'] ?? '',
            'token' => self::$wxmpSetting['token'] ?? '',
            'aes_key' => self::$wxmpSetting['aes_key'] ?? '',
            'response_type' => 'array'
        ];

        $app = \EasyWeChat\Factory::officialAccount($config);
        $app->server->push(function ($message) use ($app) {
            switch ($message['MsgType']) {
                case 'event':
                    return $this->handleEvent($app, $message);
                    break;
                case 'text':
                    return $this->handleText($app, $message);
                    break;
                default:
                    // 自定义默认回复
                    if (!empty(self::$wxmpSetting['defaultReply'])) {
                        return $this->makeReply(self::$wxmpSetting['defaultReply']);
                    }
                /*case 'image':
                    return '收到图片消息';
                    break;
                case 'voice':
                    return '收到语音消息';
                    break;
                case 'video':
                    return '收到视频消息';
                    break;
                case 'location':
                    return '收到坐标消息';
                    break;
                case 'link':
                    return '收到链接消息';
                    break;
                case 'file':
                    return '收到文件消息';
                    break;*/
            }
        });

        $response = $app->server->serve();
        ob_clean();
        $response->send();
    }

    private function handleEvent($app, $message)
    {
        if ($message['Event'] == 'subscribe') {
            if (!empty($message['EventKey'])) {
                $code = str_replace('qrscene_', '', $message['EventKey']);
            }
            if (!empty(self::$wxmpSetting['welcomeReply'])) {
                $reply = $this->makeReply(self::$wxmpSetting['welcomeReply']);
            }
        } else if ($message['Event'] == 'SCAN') {
            $code = $message['EventKey'];
            if (!empty(self::$wxmpSetting['loginReply'])) {
                $reply = $this->makeReply(self::$wxmpSetting['loginReply']);
            }
        }
        $openid = $message['FromUserName'];
        if (!empty($code) && !empty($openid)) {
            if (substr($code, 0, 4) == 'bind') {
                // 綁定微信账号
                Db::name('pclogin')
                    ->insert([
                        'site_id' => self::$site_id,
                        'openid' => $openid,
                        'code' => $code,
                        'create_time' => time()
                    ]);
                return '扫码成功';
            } else {
                // pc登录
                $user_id = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['openid_mp', '=', $openid]
                    ])
                    ->value('id');
                if (!$user_id) {
                    // $user = $app->user->get($openid);
                    $user_id = Db::name('user')
                        ->insertGetId([
                            'site_id' => self::$site_id,
                            'openid_mp' => $openid,
                            'create_time' => time()
                        ]);
                    // 送免费条数
                    giveFreeNum(self::$site_id, $user_id);
                }
                Db::name('pclogin')
                    ->insert([
                        'site_id' => self::$site_id,
                        'user_id' => $user_id,
                        'openid' => $openid,
                        'code' => $code,
                        'create_time' => time()
                    ]);
                return !empty($reply) ? $reply : '恭喜您，登录成功！请回到网页继续使用！';
            }

        }

        return !empty($reply) ? $reply : '';
    }

    private function handleText($app, $message)
    {
        // 关键词回复
        $reply = $this->makeKeywordReply($message['Content']);

        // 系统级默认回复
        if (empty($reply)) {
            $reply = '请在网页端使用对话服务';
        }
        return $reply;
    }

    private function makeReply($setting)
    {
        if ($setting['type'] == 'text' && !empty($setting['content'])) {
            return $setting['content'];
        }

        if ($setting['type'] == 'image' && !empty($setting['media_id'])) {
            return new \EasyWeChat\Kernel\Messages\Image($setting['media_id']);
        }

        return '';
    }

    // 关键词回复
    private function makeKeywordReply($text)
    {
        $text = strtolower($text);
        $keywords = Db::name('wxmp_keyword')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1]
            ])
            ->order('weight desc')
            ->select()->toArray();
        foreach ($keywords as $v) {
            // 精准关键词
            if ($v['is_hit'] == 1 && strtolower($v['keyword']) == $text) {
                return $this->makeReply([
                    'type' => $v['type'],
                    'content' => $v['content'],
                    'media_id' => $v['media_id']
                ]);
            }
        }
        foreach ($keywords as $v) {
            // 包含关键词
            if ($v['is_hit'] == 0 && strpos($text, strtolower($v['keyword'])) !== false) {
                return $this->makeReply([
                    'type' => $v['type'],
                    'content' => $v['content'],
                    'media_id' => $v['media_id']
                ]);
            }
        }
        // 自定义默认回复
        if (!empty(self::$wxmpSetting['defaultReply'])) {
            return $this->makeReply(self::$wxmpSetting['defaultReply']);
        }

        return '请在网页端使用对话服务';
    }

}
