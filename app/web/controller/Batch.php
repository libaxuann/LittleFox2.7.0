<?php

namespace app\web\controller;

use think\facade\Db;

class Batch extends Base
{
    public function getBatchList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 30, 'intval');
        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']],
            ['is_delete', '=', 0]
        ];

        try {
            $list = Db::name('batch')
                ->where($where)
                ->field('batch_id,prompt,count_finished,count_total,create_time')
                ->order('id desc')
                ->page($page, $pagesize)
                ->select()->each(function ($item) {
                    $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                    return $item;
                });
            $count = Db::name('batch')
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

    public function getBatchInfo()
    {
        $batch_id = input('batch_id', '', 'trim');
        try {
            $info = Db::name('batch')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['is_delete', '=', 0],
                    ['batch_id', '=', $batch_id]
                ])
                ->field('batch_id,ai,prompt')
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }

            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveBatchInfo()
    {
        $batch_id = input('batch_id', '', 'trim');
        $ai = input('ai', '', 'trim');
        $prompt = input('prompt', '', 'trim');

        try {
            if ($batch_id) {
                Db::name('batch')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['user_id', '=', self::$user['id']],
                        ['is_delete', '=', 0],
                        ['batch_id', '=', $batch_id]
                    ])
                    ->update([
                        'ai' => $ai,
                        'prompt' => $prompt
                    ]);
            } else {
                $batch_id = $this->createBatchId();
                Db::name('batch')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'user_id' => self::$user['id'],
                        'batch_id' => $batch_id,
                        'ai' => $ai,
                        'prompt' => $prompt,
                        'create_time' => time()
                    ]);
            }
            return successJson([
                'batch_id' => $batch_id
            ], '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    private function createBatchId()
    {
        return uniqid(self::$user['id']);
    }

    public function delBatch()
    {
        $batch_id = input('batch_id', '', 'trim');
        try {
            Db::name('batch')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['batch_id', '=', $batch_id]
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
        $batch_id = input('batch_id', '', 'trim');
        $list = Db::name('batch_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['batch_id', '=', $batch_id],
                ['is_delete', '=', 0]
            ])
            ->field('id,message,message_input,response,total_tokens,state,create_time')
            ->order('id asc')
            ->select()->each(function ($item) {
                if (!empty($item['message_input'])) {
                    $item['message'] = $item['message_input'];
                }
                if (!empty($item['response'])) {
                    $item['response'] = wordFilter($item['response']);
                }
                $item['create_time'] = date('Y-m-d H:i:s', $item['create_time']);
                unset($item['message_input']);
                return $item;
            });

        return successJson($list);
    }
    public function importTask()
    {
        $batch_id = input('batch_id', '', 'trim');
        $batch = Db::name('batch')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['batch_id', '=', $batch_id],
                ['is_delete', '=', 0]
            ])
            ->find();
        if (!$batch) {
            return errorJson('没找到此任务组，请刷新后重试');
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
            $message = trim($sheet->getCell("A" . $j)->getValue());
            if (empty($message)) {
                continue;
            }

            $rs = Db::name('batch_task')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'batch_id' => $batch_id,
                    'message' => $message,
                    'state' => 0,
                    'create_time' => time()
                ]);

            if ($rs !== false) {
                $success++;
            }
        }

        $this->updateBatchCount($batch_id);
        return successJson('', '导入成功' . $success . '条');
    }

    public function delTask()
    {
        $batch_id = input('batch_id', '', 'trim');
        $task_id = input('task_id', 0, 'intval');
        try {
            Db::name('batch_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['batch_id', '=', $batch_id],
                    ['id', '=', $task_id]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            $this->updateBatchCount($batch_id);
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }
    public function delAllTask()
    {
        $batch_id = input('batch_id', '', 'trim');
        Db::startTrans();
        try {
            Db::name('batch_task')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['batch_id', '=', $batch_id],
                    ['is_delete', '=', 0]
                ])
                ->update([
                    'is_delete' => 1
                ]);
            Db::commit();
            $this->updateBatchCount($batch_id);
            return successJson('', '已清空');
        } catch (\Exception $e) {
            Db::rollback();
            return errorJson(text('操作失败') . ': ' . $e->getMessage());
        }
    }
    public function saveTask()
    {
        $batch_id = input('batch_id', '', 'trim');
        $task_id = input('task_id', 0, 'intval');
        $message = input('message', '', 'trim');

        try {
            if ($task_id) {
                Db::name('batch_task')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['user_id', '=', self::$user['id']],
                        ['is_delete', '=', 0],
                        ['id', '=', $task_id]
                    ])
                    ->update([
                        'message' => $message
                    ]);
            } else {
                $task_id = Db::name('batch_task')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'user_id' => self::$user['id'],
                        'batch_id' => $batch_id,
                        'message' => $message,
                        'create_time' => time()
                    ]);
                $this->updateBatchCount($batch_id);
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
    private function updateBatchCount($batch_id)
    {
        $countTotal = Db::name('batch_task')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['batch_id', '=', $batch_id],
                ['is_delete', '=', 0]
            ])
            ->count();
        Db::name('batch')
            ->where([
                ['batch_id', '=', $batch_id]
            ])
            ->update([
                'count_total' => $countTotal
            ]);
    }
}
