<?php

namespace app\web\controller;

use think\facade\Db;
use think\facade\Request;
class Article
{
    private static $site_id = 0;

    public function __construct()
    {
        $site_id = input('site_id', 0, 'intval');
        if (!$site_id) {
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
            }
        }

        self::$site_id = $site_id;
    }

    /**
     * 树形目录
     */
    public function getArticleTree()
    {
        $tree = [
            [
                'isFolder' => 1,
                'title' => '使用教程',
                'son' => []
            ],
            [
                'isFolder' => 1,
                'title' => '其他文档',
                'son' => []
            ]
        ];
        $helpList = Db::name('article')
            ->where([
                ['site_id', '=', self::$site_id],
                ['type', '=', 'help']
            ])
            ->field('id,type,title')
            ->order('weight desc,id asc')
            ->select()->each(function ($item) {
                $item['isFolder'] = 0;
                $item['key'] = 'help' . $item['id'];
                return $item;
            })->toArray();
        $tree[0]['son'] = $helpList;

        $otherArticle = [
            'notice' => '通知公告',
            'service' => '服务协议',
            'privacy' => '隐私政策',
            'legal' => '免责声明',
            'commission' => '推广协议',
            'about' => '关于我们',
            'kefu' => '联系客服',
        ];
        foreach ($otherArticle as $type => $title) {
            $tree[1]['son'][] = [
                'isFolder' => 0,
                'title' => $title,
                'type' => $type,
                'key' => $type
            ];
        }

        return successJson($tree);
    }

    public function getList()
    {
        $type = input('type', 'help', 'trim');
        $list = Db::name('article')
            ->where([
                ['site_id', '=', self::$site_id],
                ['type', '=', $type]
            ])
            ->field('id,title')
            ->order('weight desc,id asc')
            ->select()->toArray();

        return successJson([
            'list' => $list
        ]);
    }

    /**
     * 取单篇文章
     */
    public function getArticle()
    {
        $type = input('type', '', 'trim');
        $where = [
            ['site_id', '=', self::$site_id],
            ['type', '=', $type]
        ];
        if ($type == 'help') {
            $id = input('id', 0, 'intval');
            $where[] = ['id', '=', $id];
        }
        $article = Db::name('article')
            ->where($where)
            ->field('title,content')
            ->find();

        if (!$article) {
            return errorJson('没有找到相关数据，请刷新页面重试');
        }
        $article['content'] = $article['content'] . '';

        return successJson($article);
    }
}
