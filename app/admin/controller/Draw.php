<?php

namespace app\admin\controller;

use think\facade\Db;

class Draw extends Base
{
    public function getList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $where = [
            'site_id' => self::$site_id,
        ];
        try {
            $list = Db::name('draw')
                ->where($where)
                ->field('id,title,price,market_price,num,weight,sales,is_default,status,create_time')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function($item) {
                    $item['price'] = $item['price'] / 100;
                    $item['market_price'] = $item['market_price'] / 100;
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    return $item;
                });
            $count = Db::name('draw')
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
     * @return string
     * 取单个套餐
     */
    public function getInfo()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('draw')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            $info['price'] = $info['price'] / 100;
            $info['market_price'] = $info['market_price'] / 100;
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    /**
     * @return string
     * 更新或新增
     */
    public function saveInfo()
    {
        $id = input('id', 0, 'intval');
        $title = input('title', '', 'trim');
        $weight = input('weight', 100, 'intval');
        $price = input('price', 0, 'floatval');
        $market_price = input('market_price', 0, 'floatval');
        $num = input('num', 0, 'intval');
        $hint = input('hint', '', 'trim');
        $desc = input('desc', '', 'trim');

        try {
            $data = [
                'title' => $title,
                'price' => $price * 100,
                'market_price' => $market_price * 100,
                'weight' => $weight,
                'num' => $num,
                'hint' => $hint,
                'desc' => $desc
            ];
            if ($id) {
                Db::name('draw')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update($data);
            } else {
				$data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('draw')
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
    public function del()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('draw')
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
     * 设置上架状态
     */
    public function setStatus()
    {
        $id = input('id', 0, 'intval');
        $status = input('status', 0, 'intval');
        try {
            Db::name('draw')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'status' => $status
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
    public function setDefault()
    {
        $id = input('id', 0, 'intval');
        $is_default = input('is_default', 0, 'intval');
        try {
            if ($is_default) {
                Db::name('draw')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['is_default', '=', 1]
                    ])
                    ->update([
                        'is_default' => 0
                    ]);
            }
            Db::name('draw')
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

    public function getMsgList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $date = input('date', []);
        $user_id = input('user_id', 0, 'intval');
        $keyword = input('keyword', '', 'trim');
        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];
        if ($user_id) {
            $where[] = ['user_id', '=', $user_id];
        }
        if ($keyword) {
            $where[] = ['message_input', 'like', '%' . $keyword . '%'];
        }
        if (!empty($date)) {
            $start_time = strtotime($date[0]);
            $end_time = strtotime($date[1]);
            $where[] = ['create_time', 'between', [$start_time, $end_time]];
        }

        $list = Db::name('msg_draw')
            ->where($where)
            ->order('id desc')
            ->page($page, $pagesize)
            ->select()->each(function ($item) {
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                $item['message'] = formatMsg($item['message']);
                $item['message_input'] = formatMsg($item['message_input']);
                if ($item['message'] == $item['message_input']) {
                    unset($item['message_input']);
                }
                if (!empty($item['options'])) {
                    $options = @json_decode($item['options'], true);
                    if (!empty($options['image'])) {
                        $item['image'] = $options['image'];
                    }
                }
                unset($options);

                if ($item['state'] == 1) {
                    $item['images'] = explode('|', $item['images']);
                }

                return $item;
            });
        $count = Db::name('msg_draw')
            ->where($where)
            ->count();

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    public function delMsg()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('msg_draw')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    public function getCateList()
    {
        try {
            $where = [
                ['site_id', '=', self::$site_id],
                ['is_delete', '=', 0]
            ];
            $list = Db::name('draw_cate')
                ->where($where)
                ->field('id,title,weight,state')
                ->order('weight desc, id asc')
                ->select()
                ->toArray();

            return successJson($list);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function getCate()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('draw_cate')
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

    public function saveCate()
    {
        $id = input('id', 0, 'intval');
        $title = input('title', '', 'trim');
        $weight = input('weight', 100, 'intval');

        try {
            $data = [
                'title' => $title,
                'weight' => $weight
            ];
            if ($id) {
                Db::name('draw_cate')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('draw_cate')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delCate()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('draw_cate')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 设置分类状态
     */
    public function setCateState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('draw_cate')
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
}
