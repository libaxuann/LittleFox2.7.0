<?php

namespace app\admin\controller;

use think\facade\Db;

class Write extends Base
{
    public function getTopicList()
    {
        try {
            $where = [
                ['site_id', '=', self::$site_id]
            ];
            $list = Db::name('write_topic')
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

    public function getTopic()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('write_topic')
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

    public function saveTopic()
    {
        $id = input('id', 0, 'intval');
        $title = input('title', '', 'trim');
        $weight = input('weight', 100, 'intval');

        try {
            $data = [
                'title' => $title,
                'weight' => $weight,
                'update_time' => time()
            ];
            if ($id) {
                Db::name('write_topic')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('write_topic')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delTopic()
    {
        $id = input('id', 0, 'intval');
        try {
            $rs = Db::name('write_prompts')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['topic_id', '=', $id]
                ])
                ->find();
            if ($rs) {
                return errorJson('请先清空本分类内的模型');
            }
            Db::name('write_topic')
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
     * 设置分类状态
     */
    public function setTopicState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('write_topic')
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

    public function getPromptList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $topic_id = input('topic_id', 'all');
        $keyword = input('keyword', '', 'trim');

        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];
        if ($topic_id && $topic_id != 'all') {
            $where[] = ['topic_id', '=', $topic_id];
        }
        if ($keyword) {
            $where[] = ['title', 'like', '%' . $keyword . '%'];
        }

        try {
            $list = Db::name('write_prompts')
                ->where($where)
                ->field('id,topic_id,title,desc,views,usages,votes,weight,state')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function ($item) {
                    $item['topic_title'] = Db::name('write_topic')
                        ->where('id', $item['topic_id'])
                        ->value('title');
                    return $item;
                })
                ->toArray();

            $count = Db::name('write_prompts')
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

    public function exportPrompt()
    {
        $topic_id = input('topic_id', 'all');
        $keyword = input('keyword', '', 'trim');

        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];
        if ($topic_id && $topic_id != 'all') {
            $where[] = ['topic_id', '=', $topic_id];
        }
        if ($keyword) {
            $where[] = ['title', 'like', '%' . $keyword . '%'];
        }

        $list = Db::name('write_prompts')
            ->where($where)
            ->field('id,topic_id,title,desc,prompt,hint,welcome,tips')
            ->order('weight desc, id asc')
            ->select()->each(function ($item) {
                $item['topic_title'] = Db::name('write_topic')
                    ->where('id', $item['topic_id'])
                    ->value('title');
                unset($item['topic_id']);
                return $item;
            })
            ->toArray();

        return successJson($list);
    }

    public function getPrompt()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('write_prompts')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id],
                    ['is_delete', '=', 0]
                ])
                ->field('id,title,topic_id,desc,prompt,hint,welcome,tips,fake_votes,fake_views,fake_usages,weight')
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function savePrompt()
    {
        $id = input('id', 0, 'intval');
        $topic_id = input('topic_id', 0, 'intval');
        $title = input('title', '', 'trim');
        $desc = input('desc', '', 'trim');
        $prompt = input('prompt', '', 'trim');
        $hint = input('hint', '', 'trim');
        $welcome = input('welcome', '', 'trim');
        $tips = input('tips', '', 'trim');
        $weight = input('weight', 100, 'intval');
        $fake_votes = input('fake_votes', 0, 'intval');
        $fake_views = input('fake_views', 0, 'intval');
        $fake_usages = input('fake_usages', 0, 'intval');

        try {
            $data = [
                'topic_id' => $topic_id,
                'title' => $title,
                'desc' => $desc,
                'prompt' => $prompt,
                'hint' => $hint,
                'welcome' => $welcome,
                'tips' => $tips,
                'weight' => $weight,
                'fake_votes' => $fake_votes,
                'fake_views' => $fake_views,
                'fake_usages' => $fake_usages,
                'update_time' => time()
            ];
            if ($id) {
                Db::name('write_prompts')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('write_prompts')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delPrompt()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('write_prompts')
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
     * 设置模型状态
     */
    public function setPromptState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('write_prompts')
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
     * 导入模型excel
     */
    public function importPrompt()
    {
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

        //循环读取excel表格，整合成数组。如果是不指定key的二维，就用$data[i][j]表示。
        $success = 0;
        for ($j = 1; $j <= $highestRow; $j++) {
            $topic_title = trim($sheet->getCell("A" . $j)->getValue());
            #1.判断有没有表头
            if ($topic_title == '模型类别') {
                continue;
            }
            $title = trim($sheet->getCell("B" . $j)->getValue());
            $desc = trim($sheet->getCell("C" . $j)->getValue());
            $prompt = trim($sheet->getCell("D" . $j)->getValue());
            $hint = trim($sheet->getCell("E" . $j)->getValue());
            $welcome = trim($sheet->getCell("F" . $j)->getValue());
            $tips = trim($sheet->getCell("G" . $j)->getValue());
            if (empty($title) || empty($prompt)) {
                continue;
            }

            #2.检查有没有重复内容
            $info = Db::name('write_prompts')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['title', '=', $title],
                    ['prompt', '=', $prompt]
                ])
                ->find();
            if ($info) {
                continue;
            }

            #3.获取类型id，如果没有则插入一条新的
            $topic_id = Db::name('write_topic')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['title', '=', $topic_title]
                ])
                ->value('id');
            if (!$topic_id) {
                $topic_id = Db::name('write_topic')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'title' => $topic_title,
                        'weight' => 100,
                        'state' => 1,
                        'create_time' => time()
                    ]);
            }
            $rs = Db::name('write_prompts')
                ->insert([
                    'site_id' => self::$site_id,
                    'type' => 'import',
                    'topic_id' => $topic_id,
                    'title' => $title,
                    'desc' => $desc,
                    'prompt' => $prompt,
                    'hint' => $hint,
                    'welcome' => $welcome,
                    'tips' => $tips,
                    'create_time' => time()
                ]);

            if ($rs !== false) {
                $success++;
            }
        }
        if ($success == $lines) {
            return successJson('', '已全部导入');
        } else {
            return successJson('', '导入成功' . $success . '条记录');
        }
    }
}
