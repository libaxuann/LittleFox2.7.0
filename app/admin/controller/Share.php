<?php

namespace app\admin\controller;

use think\facade\Db;

class Share extends Base
{
    public function getTextList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $where = [
            'site_id' => self::$site_id
        ];
        try {
            $list = Db::name('share_text')
                ->where($where)
                ->field('id,content,is_default,state,weight,create_time')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    return $item;
                });
            $count = Db::name('share_text')
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
    
    public function getTextInfo()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('share_text')
                ->where([
                    ['site_id', '=', self::$site_id],
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

    /**
     * @return string
     * 更新或新增
     */
    public function saveTextInfo()
    {
        $id = input('id', 0, 'intval');
        $content = input('content', '', 'trim');
        $weight = input('weight', 100, 'intval');

        try {
            $data = [
                'content' => $content,
                'weight' => $weight
            ];
            if ($id) {
                Db::name('share_text')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update($data);
            } else {
				$data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('share_text')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 删除
     */
    public function delText()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('share_text')
                ->where([
                    ['site_id', '=', self::$site_id],
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
     * 设置启用状态
     */
    public function setTextState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('share_text')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'state' => $state
                ]);
            return successJson('', '设置成功');
        } catch (\Exception $e) {
            return errorJson(text('设置失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 设置默认
     */
    public function setTextDefault()
    {
        $id = input('id', 0, 'intval');
        $is_default = input('is_default', 0, 'intval');
        try {
            if ($is_default) {
                Db::name('share_text')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['is_default', '=', 1]
                    ])
                    ->update([
                        'is_default' => 0
                    ]);
            }
            Db::name('share_text')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'is_default' => $is_default ? 1 : 0
                ]);
            return successJson('', '设置成功');
        } catch (\Exception $e) {
            return errorJson(text('设置失败') . ': ' . $e->getMessage());
        }
    }
    
    public function getHaibaoList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $where = [
            'site_id' => self::$site_id
        ];
        try {
            $list = Db::name('share_haibao')
                ->where($where)
                ->field('id,bg,is_default,state,weight,create_time')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    return $item;
                });
            $count = Db::name('share_haibao')
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
    
    public function getHaibaoInfo()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('share_haibao')
                ->where([
                    ['site_id', '=', self::$site_id],
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

    /**
     * @return string
     * 更新或新增
     */
    public function saveHaibaoInfo()
    {
        $id = input('id', 0, 'intval');
        $bg = input('bg', '', 'trim');
        $bg_w = input('bg_w', 0, 'intval');
        $bg_h = input('bg_h', 0, 'intval');
        $hole_w = input('hole_w', 0, 'intval');
        $hole_h = input('hole_h', 0, 'intval');
        $hole_x = input('hole_x', 0, 'intval');
        $hole_y = input('hole_y', 0, 'intval');
        $weight = input('weight', 100, 'intval');

        try {
            $data = [
                'bg' => $bg,
                'bg_w' => $bg_w,
                'bg_h' => $bg_h,
                'hole_w' => $hole_w,
                'hole_h' => $hole_h,
                'hole_x' => $hole_x,
                'hole_y' => $hole_y,
                'weight' => $weight
            ];
            if ($id) {
                Db::name('share_haibao')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update($data);
            } else {
				$data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('share_haibao')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 删除
     */
    public function delHaibao()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('share_haibao')
                ->where([
                    ['site_id', '=', self::$site_id],
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
     * 设置启用状态
     */
    public function setHaibaoState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('share_haibao')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'state' => $state
                ]);
            return successJson('', '设置成功');
        } catch (\Exception $e) {
            return errorJson(text('设置失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 设置默认
     */
    public function setHaibaoDefault()
    {
        $id = input('id', 0, 'intval');
        $is_default = input('is_default', 0, 'intval');
        try {
            if ($is_default) {
                Db::name('share_haibao')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['is_default', '=', 1]
                    ])
                    ->update([
                        'is_default' => 0
                    ]);
            }
            Db::name('share_haibao')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'is_default' => $is_default ? 1 : 0
                ]);
            return successJson('', '设置成功');
        } catch (\Exception $e) {
            return errorJson(text('设置失败') . ': ' . $e->getMessage());
        }
    }
}
