<?php

namespace app\web\controller;

use think\facade\Db;

class Novel extends Base
{
    public function getNovelList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 30, 'intval');
        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']],
            ['is_delete', '=', 0]
        ];

        try {
            $list = Db::name('novel')
                ->where($where)
                ->field('novel_id,title,prompt,overview,sketch,count_finished,count_total,words,create_time')
                ->order('id desc')
                ->page($page, $pagesize)
                ->select()->each(function ($item) {
                    $item['create_time'] = date('Y/m/d H:i', $item['create_time']);
                    return $item;
                });
            $count = Db::name('novel')
                ->where($where)
                ->count();

            return successJson([
                'list' => $list,
                'count' => $count
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function getNovelInfo()
    {
        $novel_id = input('novel_id', '', 'trim');
        try {
            $info = Db::name('novel')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['is_delete', '=', 0],
                    ['novel_id', '=', $novel_id]
                ])
                ->field('novel_id,ai,title,prompt,overview,sketch')
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }

            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveNovelInfo()
    {
        $novel_id = input('novel_id', '', 'trim');
        $ai = input('ai', '', 'trim');
        $title = input('title', '', 'trim');
        $prompt = input('prompt', '', 'trim');
        $overview = input('overview', '', 'trim');
        $sketch = input('sketch', '', 'trim');

        try {
            if ($novel_id) {
                Db::name('novel')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['user_id', '=', self::$user['id']],
                        ['is_delete', '=', 0],
                        ['novel_id', '=', $novel_id]
                    ])
                    ->update([
                        'ai' => $ai,
                        'title' => $title,
                        'prompt' => $prompt,
                        'overview' => $overview,
                        'sketch' => $sketch
                    ]);
            } else {
                $novel_id = $this->createNovelId();
                Db::name('novel')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'user_id' => self::$user['id'],
                        'novel_id' => $novel_id,
                        'ai' => $ai,
                        'title' => $title,
                        'prompt' => $prompt,
                        'overview' => $overview,
                        'sketch' => $sketch,
                        'create_time' => time()
                    ]);
            }
            return successJson([
                'novel_id' => $novel_id
            ], '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    private function createNovelId()
    {
        return uniqid(self::$user['id']);
    }

    public function delNovel()
    {
        $novel_id = input('novel_id', '', 'trim');
        try {
            $count = Db::name('novel_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['novel_id', '=', $novel_id],
                    ['is_delete', '=', 0]
                ])
                ->count();
            if ($count > 0) {
                return errorJson('请先清空章节');
            }
            Db::name('novel')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['novel_id', '=', $novel_id]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    public function getTaskList()
    {
        $novel_id = input('novel_id', '', 'trim');
        $list = Db::name('novel_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', $novel_id],
                ['is_delete', '=', 0]
            ])
            ->field('id,title,overview,response,total_tokens,state,create_time')
            ->order('id asc')
            ->select()->each(function ($item) {
                if (!empty($item['response'])) {
                    $item['response'] = wordFilter($item['response']);
                }
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                return $item;
            });

        return successJson($list);
    }
    public function importTask()
    {
        $novel_id = input('novel_id', '', 'trim');
        $novel = Db::name('novel')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', $novel_id],
                ['is_delete', '=', 0]
            ])
            ->find();
        if (!$novel) {
            return errorJson('没找到作品，请刷新后重试');
        }
        // 获取表单上传文件
        $file[] = request()->file('file');
        $savename = \think\facade\Filesystem::putFile('file', $file[0]);
        $fileExtendName = substr(strrchr($savename, '.'), 1);
        // 有Xls和Xlsx格式两种
        if ($fileExtendName == 'xlsx') {
            $objReader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader('Xlsx');
        } else {
            $objReader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader('Xls');
        }
        $objReader->setReadDataOnly(TRUE);
        // 读取文件，tp6默认上传的文件，在runtime的相应目录下，可根据实际情况自己更改

        $objPHPExcel = $objReader->load(root_path() . '/runtime/upload/' . $savename);
        $sheet = $objPHPExcel->getSheet(0);   //excel中的第一张sheet

        $highestRow = $sheet->getHighestRow();       // 取得总行数
        $highestColumn = $sheet->getHighestColumn();   // 取得总列数
        \PhpOffice\PhpSpreadsheet\Cell\Coordinate::columnIndexFromString($highestColumn);
        $lines = $highestRow - 1;
        if ($lines <= 0) {
            return errorJson('文档内没有数据');
        }

        $success = 0;
        for ($j = 1; $j <= $highestRow; $j++) {
            $title = trim($sheet->getCell("A" . $j)->getValue());
            $overview = trim($sheet->getCell("B" . $j)->getValue());
            $content = trim($sheet->getCell("C" . $j)->getValue());
            if (empty($title) || $title == '章节标题') {
                continue;
            }

            $rs = Db::name('novel_task')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'novel_id' => $novel_id,
                    'title' => $title,
                    'overview' => $overview,
                    'response' => $content,
                    'state' => 0,
                    'words' => mb_strlen($content),
                    'create_time' => time()
                ]);

            if ($rs !== false) {
                $success++;
            }
        }

        $this->updateNovelCount($novel_id);
        return successJson('', '导入成功' . $success . '条');
    }

    public function delTask()
    {
        $novel_id = input('novel_id', '', 'trim');
        $task_id = input('task_id', 0, 'intval');
        try {
            Db::name('novel_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['novel_id', '=', $novel_id],
                    ['id', '=', $task_id]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            $this->updateNovelCount($novel_id);
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }
    public function delAllTask()
    {
        $novel_id = input('novel_id', '', 'trim');
        Db::startTrans();
        try {
            Db::name('novel_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['novel_id', '=', $novel_id],
                    ['is_delete', '=', 0]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            Db::commit();
            $this->updateNovelCount($novel_id);
            return successJson('', '已清空');
        } catch (\Exception $e) {
            Db::rollback();
            return errorJson(text('操作失败') . ': ' . $e->getMessage());
        }
    }
    public function saveTask()
    {
        $novel_id = input('novel_id', '', 'trim');
        $task_id = input('task_id', 0, 'intval');
        $title = input('title', '', 'trim');
        $overview = input('overview', '', 'trim');

        try {
            if ($task_id) {
                Db::name('novel_task')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['user_id', '=', self::$user['id']],
                        ['is_delete', '=', 0],
                        ['id', '=', $task_id]
                    ])
                    ->update([
                        'title' => $title,
                        'overview' => $overview
                    ]);
            } else {
                $task_id = Db::name('novel_task')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'user_id' => self::$user['id'],
                        'novel_id' => $novel_id,
                        'title' => $title,
                        'overview' => $overview,
                        'create_time' => time()
                    ]);
                $this->updateNovelCount($novel_id);
            }
            return successJson([
                'task_id' => $task_id
            ], '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * 更新任务组的任务数统计
     */
    private function updateNovelCount($novel_id)
    {
        $countTotal = Db::name('novel_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', $novel_id],
                ['is_delete', '=', 0]
            ])
            ->count();
        $countFinished = Db::name('novel_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', $novel_id],
                ['is_delete', '=', 0],
            ])->whereNotNull('response')
            ->count();

        Db::name('novel')
            ->where([
                ['novel_id', '=', $novel_id]
            ])
            ->update([
                'count_total' => $countTotal,
                'count_finished' => $countFinished
            ]);
    }

    /**
     * 清除章节内容
     */
    public function clearTaskResponse()
    {
        $novel_id = input('novel_id', '', 'trim');
        $task_id = input('task_id', 0, 'intval');
        $rs = Db::name('novel_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['novel_id', '=', $novel_id],
                ['id', '=', $task_id]
            ])
            ->update([
                'response' => '',
                'total_tokens' => 0,
                'words' => 0,
                'state' => 0
            ]);
        if ($rs !== false) {
            $this->updateNovelCount($novel_id);
            return successJson();
        } else {
            return errorJson('操作失败，请重试');
        }
    }
}
