<?php

namespace app\admin\controller;

use think\facade\Db;

class Article extends Base
{
    public function getHelpList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        try {
            $where = [
                'site_id' => self::$site_id,
                'type' => 'help'
            ];
            $list = Db::name('article')
                ->where($where)
                ->field('id,title,weight,views,create_time')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    return $item;
                });
            $count = Db::name('article')
                ->where($where)
                ->count();
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    /**
     * 取单个文章
     */
    public function getHelpArticle()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('article')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['type', '=', 'help'],
                    ['id', '=', $id]
                ])
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }
    public function saveHelpArticle()
    {
        $id = input('id', 0, 'intval');
        $title = input('title', '', 'trim');
        $weight = input('weight', 100, 'intval');
        $content = input('content', '', 'trim');

        try {
            $data = [
                'type' => 'help',
                'title' => $title,
                'content' => $content,
                'weight' => $weight
            ];
            if ($id) {
                Db::name('article')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['type', '=', 'help'],
                        ['id', '=', $id]
                    ])
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('article')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 删除文章
     */
    public function delHelpArticle()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('article')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['type', '=', 'help'],
                    ['id', '=', $id]
                ])
                ->delete();
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 取单个文章
     */
    public function getArticle()
    {
        $type = input('type', '', 'trim');

        try {
            $article = Db::name('article')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['type', '=', $type]
                ])
                ->find();
            return successJson($article);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * @return string
     * 更新或新增
     */
    public function saveArticle()
    {
        $title = input('title', '', 'trim');
        $content = input('content', '', 'trim');
        $type = input('type', '', 'trim');

        try {
            $article = Db::name('article')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['type', '=', $type]
                ])
                ->find();
            if ($article) {
                Db::name('article')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['type', '=', $type]
                    ])
                    ->update([
                        'type' => $type,
                        'title' => $title,
                        'content' => $content
                    ]);
            } else {
                Db::name('article')
                    ->insert([
                        'site_id' => self::$site_id,
                        'type' => $type,
                        'title' => $title,
                        'content' => $content,
                        'create_time' => time()
                    ]);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }
}
