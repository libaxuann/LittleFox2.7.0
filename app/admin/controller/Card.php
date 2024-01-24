<?php

namespace app\admin\controller;

use think\facade\Db;

class Card extends Base
{
    public function getBatchList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $page = max(1, $page);
        $pagesize = max(1, $pagesize);
        $keyword = input('keyword', '', 'trim');

        $where = [
            ['site_id', '=', self::$site_id]
        ];
        if ($keyword) {
            $where[] = ['remark', 'like', '%' . $keyword . '%'];
        };

        // 查询列表
        $list = Db::name('card_batch')
            ->where($where)
            ->page($page, $pagesize)
            ->order('id desc')
            ->select()->each(function ($item) {
                $item['create_time'] = date('Y-m-d H:i', $item['create_time']);
                $item['used'] = Db::name('card')
                    ->where([
                        ['batch_id', '=', $item['id']],
                        ['user_id', '>', 0]
                    ])
                    ->count();
                return $item;
            });
        $count = Db::name('card_batch')
            ->where($where)
            ->count();

        return successJson([
            'count' => $count,
            'list' => $list
        ]);
    }

    public function createBatch()
    {
        $now = time();
        $type = input('type', '', 'trim');
        $val = input('val', 0, 'intval');
        $num = input('num', 0, 'intval');
        $remark = input('remark', '', 'trim');

        if (!$type || $val <= 0 || $num <= 0) {
            return errorJson('输入有误');
        }

        if ($num > 2000) {
            return errorJson('每次最多生成2000个');
        }
        // 创建批次
        Db::startTrans();
        try {
            $batch_id = Db::name('card_batch')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'num' => $num,
                    'type' => $type,
                    'val' => $val,
                    'remark' => $remark,
                    'create_time' => $now
                ]);

            for ($i = 0; $i < $num; $i++) {
                while(1) {
                    $code = getNonceStr(8);
                    $rs = Db::name('card')
                        ->where([
                            ['site_id', '=', self::$site_id],
                            ['code', '=', $code]
                        ])
                        ->find();
                    if (!$rs) {
                        Db::name('card')
                            ->insertGetId([
                                'site_id' => self::$site_id,
                                'batch_id' => $batch_id,
                                'code' => $code,
                                'type' => $type,
                                'val' => $val,
                                'create_time' => $now
                            ]);
                        break;
                    }
                }

            }

            Db::commit();
            return successJson('', '生成成功');

        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return errorJson('生成失败，请重试！' . $e->getMessage());
        }
    }

    /**
     * 删除
     */
    public function batchDel()
    {
        $id = input('id', 0, 'intval');
        // 开启删除事务
        Db::startTrans();
        try {
            Db::name('card')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['batch_id', '=', $id]
                ])
                ->delete();
            Db::name('card_batch')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->delete();
            Db::commit();
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return errorJson('删除失败，请重试！');
        }
    }

    /**
     * 获取某批次的卡密列表
     */
    public function getBatchCard()
    {
        $batch_id = input('batch_id', 0, 'intval');
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $page = max(1, $page);
        $pagesize = max(1, $pagesize);

        // 查询列表
        $where = [
            ['site_id', '=', self::$site_id],
            ['batch_id', '=', $batch_id]
        ];
        $list = Db::name('card')
            ->where($where)
            ->field('id,user_id,code,type,val,bind_time,create_time')
            ->page($page, $pagesize)
            ->select()->each(function ($item) {
                if ($item['user_id']) {
                    $item['user'] = Db::name('user')
                        ->where([
                            ['site_id', '=', self::$site_id],
                            ['id', '=', $item['user_id']]
                        ])
                        ->field('avatar,nickname')
                        ->find();
                    $item['bind_time'] = date('Y-m-d H:i:s', $item['bind_time']);
                } else {
                    $item['bind_time'] = '';
                }
                return $item;
            });
        $count = Db::name('card')
            ->where($where)
            ->count();

        return successJson([
            'count' => $count,
            'list' => $list
        ]);
    }

    /**
     * 卡密使用记录
     */
    public function getCardLogs()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $page = max(1, $page);
        $pagesize = max(1, $pagesize);
        $code = input('code', '', 'trim');
        $user_id = input('user_id', 0, 'intval');

        // 查询列表
        $where = [
            ['site_id', '=', self::$site_id]
        ];
        if ($user_id) {
            $where[] = ['user_id', '=', $user_id];
        } else {
            $where[] = ['user_id', '>', 0];
        }
        if ($code) {
            $where[] = ['code', '=', $code];
        }
        $list = Db::name('card')
            ->where($where)
            ->field('id,user_id,code,type,val,bind_time,create_time')
            ->order('bind_time desc')
            ->page($page, $pagesize)
            ->select()->each(function ($item) {
                $item['user'] = Db::name('user')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $item['user_id']]
                    ])
                    ->field('avatar,nickname')
                    ->find();
                $item['bind_time'] = date('Y-m-d H:i:s', $item['bind_time']);

                return $item;
            });
        $count = Db::name('card')
            ->where($where)
            ->count();

        return successJson([
            'count' => $count,
            'list' => $list
        ]);
    }

    /**
     * 解绑
     */
    public function unbind()
    {
        $id = input('id', 0, 'intval');
        $rs = Db::name('card')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $id]
            ])
            ->update([
                'user_id' => 0,
                'bind_time' => 0
            ]);
        if ($rs !== false) {
            return successJson('', '设置成功');
        } else {
            return errorJson('设置失败，请重试！');
        }
    }

    public function getBatchExport()
    {
        $batch_id = input('batch_id', 0, 'intval');
        $unbind = input('unbind', 0, 'intval');
        $where = [
            ['site_id', '=', self::$site_id],
            ['batch_id', '=', $batch_id]
        ];
        if ($unbind) {
            $where[] = ['user_id', '=', 0];
        }
        $list = Db::name('card')
            ->where($where)
            ->select()->each(function ($item) {
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                if ($item['user_id']) {
                    $item['bind_time'] = date('Y-m-d H:i:s', $item['bind_time']);
                } else {
                    $item['user_id'] = '';
                    $item['bind_time'] = '';
                }
                if ($item['type'] == 'times') {
                    $item['val'] = $item['val'] . text('条');
                    $item['type'] = text('次数');
                }
                elseif ($item['type'] == 'vip') {
                    $item['val'] = $item['val'] . text('个月');
                    $item['type'] = text('时长');
                }
                return $item;
            })->toArray();

        return successJson($list);
    }

}
