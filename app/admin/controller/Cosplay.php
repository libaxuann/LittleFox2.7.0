<?php

namespace app\admin\controller;

use think\facade\Db;

class Cosplay extends Base
{
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
            $where[] = ['message', 'like', '%' . $keyword . '%'];
        }
        if (!empty($date)) {
            $start_time = strtotime($date[0]);
            $end_time = strtotime($date[1]);
            $where[] = ['create_time', 'between', [$start_time, $end_time]];
        }

        $list = Db::name('msg_cosplay')
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
                $item['response'] = formatMsg($item['response']);
                $item['response_input'] = formatMsg($item['response_input']);
                if ($item['response'] == $item['response_input']) {
                    unset($item['response_input']);
                }
                $item['type_title'] = Db::name('cosplay_type')
                    ->where('id', $item['type_id'])
                    ->value('title');
                $item['role_title'] = Db::name('cosplay_role')
                    ->where('id', $item['role_id'])
                    ->value('title');
                return $item;
            });
        $count = Db::name('msg_cosplay')
            ->where($where)
            ->count();

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    /**
     * 统计
     */
    public function getMsgTongji()
    {
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
            $where[] = ['message_input|response_input', 'like', '%' . $keyword . '%'];
        }
        if (!empty($date)) {
            $start_time = strtotime($date[0]);
            $end_time = strtotime($date[1]);
            $where[] = ['create_time', 'between', [$start_time, $end_time]];
        }
        $data = Db::name('msg_cosplay')
            ->where($where)
            ->field('count(id) as msg_count,sum(total_tokens) as msg_tokens')
            ->find();

        return successJson([
            'msgCount' => intval($data['msg_count']),
            'msgTokens' => intval($data['msg_tokens'])
        ]);
    }

    public function delMsg()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('msg_cosplay')
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

    public function getTypeList()
    {
        try {
            $where = [
                ['site_id', '=', self::$site_id]
            ];
            $list = Db::name('cosplay_type')
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

    public function getType()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('cosplay_type')
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

    public function saveType()
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
                Db::name('cosplay_type')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('cosplay_type')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delType()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('cosplay_type')
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
    public function setTypeState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('cosplay_type')
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

    public function getRoleList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $type_id = input('type_id', 'all');
        $keyword = input('keyword', '', 'trim');

        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];
        if ($type_id && $type_id != 'all') {
            $where[] = ['type_id', '=', $type_id];
        }
        if ($keyword) {
            $where[] = ['title', 'like', '%' . $keyword . '%'];
        }

        try {
            $list = Db::name('cosplay_role')
                ->where($where)
                ->field('id,type_id,title,thumb,desc,views,usages,weight,state')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function ($item) {
                    $item['type_title'] = Db::name('cosplay_type')
                        ->where('id', $item['type_id'])
                        ->value('title');
                    return $item;
                })
                ->toArray();

            $count = Db::name('cosplay_role')
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

    public function exportRoles()
    {
        $type_id = input('type_id', 'all');
        $keyword = input('keyword', '', 'trim');

        $where = [
            ['site_id', '=', self::$site_id],
            ['is_delete', '=', 0]
        ];
        if ($type_id && $type_id != 'all') {
            $where[] = ['type_id', '=', $type_id];
        }
        if ($keyword) {
            $where[] = ['title', 'like', '%' . $keyword . '%'];
        }

        $list = Db::name('cosplay_role')
            ->where($where)
            ->field('id,type_id,title,desc,thumb,prompt,hint,welcome,tips')
            ->order('weight desc, id asc')
            ->select()->each(function ($item) {
                $item['type_title'] = Db::name('cosplay_type')
                    ->where('id', $item['type_id'])
                    ->value('title');
                unset($item['type_id']);
                return $item;
            })
            ->toArray();

        return successJson($list);
    }

    public function getRole()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('cosplay_role')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id],
                    ['is_delete', '=', 0]
                ])
                ->field('id,title,thumb,type_id,desc,prompt,hint,welcome,tips,fake_views,fake_usages,weight,book_open,books,no_answer_action,answer_content')
                ->find();
            if (!$info) {
                return errorJson('没有找到数据，请刷新页面重试');
            }
            if (!empty($info['books'])) {
                $info['books'] = json_decode($info['books'], true);
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveRole()
    {
        $id = input('id', 0, 'intval');
        $type_id = input('type_id', 0, 'intval');
        $title = input('title', '', 'trim');
        $thumb = input('thumb', '', 'trim');
        $desc = input('desc', '', 'trim');
        $prompt = input('prompt', '', 'trim');
        $hint = input('hint', '', 'trim');
        $welcome = input('welcome', '', 'trim');
        $tips = input('tips', '', 'trim');
        $weight = input('weight', 100, 'intval');
        $fake_views = input('fake_views', 0, 'intval');
        $fake_usages = input('fake_usages', 0, 'intval');
        $book_open = input('book_open', 0, 'intval');
        $books = input('books', '', 'trim');
        $no_answer_action = input('no_answer_action', 'ai', 'trim');
        $answer_content = input('answer_content', '', 'trim');

        try {
            $data = [
                'type_id' => $type_id,
                'title' => $title,
                'thumb' => $thumb,
                'desc' => $desc,
                'prompt' => $prompt,
                'hint' => $hint,
                'welcome' => $welcome,
                'tips' => $tips,
                'weight' => $weight,
                'fake_views' => $fake_views,
                'fake_usages' => $fake_usages,
                'book_open' => $book_open,
                'books' => $books,
                'no_answer_action' => $no_answer_action,
                'answer_content' => $answer_content,
                'update_time' => time()
            ];
            if ($id) {
                Db::name('cosplay_role')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('cosplay_role')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delRole()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('cosplay_role')
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
     * 设置角色状态
     */
    public function setRoleState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('cosplay_role')
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
     * 导入角色excel
     */
    public function importRoles()
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
            $type_title = trim($sheet->getCell("A" . $j)->getValue());
            #1.判断有没有表头
            if ($type_title == '所属类别') {
                continue;
            }
            $title = trim($sheet->getCell("B" . $j)->getValue());
            $thumb = trim($sheet->getCell("C" . $j)->getValue());
            $prompt = trim($sheet->getCell("D" . $j)->getValue());
            $hint = trim($sheet->getCell("E" . $j)->getValue());
            $welcome = trim($sheet->getCell("F" . $j)->getValue());
            $tips = trim($sheet->getCell("G" . $j)->getValue());
            if (empty($title) || empty($prompt)) {
                continue;
            }

            #2.检查有没有重复内容
            $info = Db::name('cosplay_role')
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
            $type_id = Db::name('cosplay_type')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['title', '=', $type_title]
                ])
                ->value('id');
            if (!$type_id) {
                $type_id = Db::name('cosplay_type')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'title' => $type_title,
                        'weight' => 100,
                        'state' => 1,
                        'create_time' => time()
                    ]);
            }
            $rs = Db::name('cosplay_role')
                ->insert([
                    'site_id' => self::$site_id,
                    'type_id' => $type_id,
                    'title' => $title,
                    'thumb' => $thumb,
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
