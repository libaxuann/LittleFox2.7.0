<?php

namespace app\web\controller;

use think\facade\Request;
use think\facade\Db;

class Base
{
    protected static $user;
    protected static $site_id;
    protected static $sitecode;

    public function __construct()
    {
        $token = Request::header('x-token');
        if ($token) {
            if ($token == 'undefined') {
                $this->handleNotLogin();
            }
            session_id($token);
        } else {
            $site_id = input('site_id', 0, 'intval');
            if ($site_id) {
                self::$site_id = $site_id;
            }
        }
        session_start();
        session_write_close();
        self::$sitecode = Request::header('x-site');

        if (!empty(self::$sitecode) && !empty($_SESSION['sitecode']) && $_SESSION['sitecode'] != self::$sitecode) {
            $this->handleNotLogin();
        } elseif (empty($_SESSION['user'])) {
            $this->handleNotLogin();
        } else {
            $user = json_decode($_SESSION['user'], true);
            if (empty($user['openid']) && empty($user['openid_mp']) && empty($user['phone']) && empty($user['authcode'])) {
                $this->handleNotLogin();
            } else {
                self::$user = $user;
                self::$site_id = $user['site_id'];
            }
        }
    }

    private function handleNotLogin()
    {
        $canNotLogin = [
            'Chat/getHistoryMsg',
            'Chat/getChatSetting',
            'Commission/makePoster',
            'Cosplay/getAllRoles',
            'Cosplay/getRole',
            'Cosplay/getHistoryMsg',
            'Draw/getDrawSetting',
            'Draw/getDrawCate',
            'Draw/getHistoryMsg',
            'Draw/getWordsCate',
            'Draw/getWordsList',
            'Group/getGroupList',
            'H5/hasModel4',
            'H5/getShareInfo',
            'H5/getSetting',
            'Order/getGoodsList',
            'Write/getTopicList',
            'Write/getPrompts',
            'Write/getAllPrompt',
            'Write/getPrompt',
            'Write/getHistoryMsg',
        ];
        $route = Request::controller() . '/' . Request::action();
        if (!in_array($route, $canNotLogin)) {
            if ($route == 'Chat/sendText') {
                echo '[error]请登录';
            } else {
                echo json_encode(['errno' => 403, 'message' => text('请登录')]);
            }
            exit;
        } else {
            if (!self::$site_id) {
                if (self::$sitecode) {
                    $site_id = Db::name('site')
                        ->where('sitecode', self::$sitecode)
                        ->value('id');
                }
                self::$site_id = !empty($site_id) ? $site_id : 1;
            }
            if (!self::$user) {
                self::$user = [
                    'id' => 0
                ];
            }
        }
    }
}
