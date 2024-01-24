<?php

namespace app\admin\controller;

use think\facade\Db;

class Book extends Base
{
    public function getBookList()
    {
        try {
            $where = [
                ['site_id', '=', self::$site_id]
            ];
            $list = Db::name('book')
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

    public function getBook()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('book')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->find();
            if (!$info) {
                return errorJson(lang('not found data'));
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveBook()
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
                Db::name('book')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('book')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delBook()
    {
        $id = input('id', 0, 'intval');
        Db::startTrans();
        try {
            Db::name('book')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->delete();
            Db::name('book_data')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['book_id', '=', $id]
                ])
                ->delete();
            Db::commit();
            return successJson('', '删除成功');
        } catch (\Exception $e) {
            Db::rollback();
            return errorJson(text('删除失败') . ': ' . $e->getMessage());
        }
    }

    /**
     * @return string
     * 设置知识库状态
     */
    public function setBookState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            Db::name('book')
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

    public function getDataList()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $book_id = input('book_id', 'all');

        $where = [
            ['site_id', '=', self::$site_id]
        ];
        if ($book_id && $book_id != 'all') {
            $where[] = ['book_id', '=', $book_id];
        }

        try {
            $list = Db::name('book_data')
                ->where($where)
                ->field('id,book_id,title,content,state')
                ->order('weight desc, id asc')
                ->page($page, $pagesize)
                ->select()->each(function ($item) {
                    $item['book_title'] = Db::name('book')
                        ->where('id', $item['book_id'])
                        ->value('title');
                    return $item;
                })
                ->toArray();

            $count = Db::name('book_data')
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

    public function exportData()
    {
        $book_id = input('book_id', 'all');

        $where = [
            ['site_id', '=', self::$site_id]
        ];
        if ($book_id && $book_id != 'all') {
            $where[] = ['book_id', '=', $book_id];
        }

        $list = Db::name('book_data')
            ->where($where)
            ->field('id,book_id,title,content')
            ->order('weight desc, id asc')
            ->select()->each(function ($item) {
                $item['book_title'] = Db::name('book')
                    ->where('id', $item['book_id'])
                    ->value('title');
                unset($item['book_id']);
                return $item;
            })
            ->toArray();

        return successJson($list);
    }

    public function getData()
    {
        $id = input('id', 0, 'intval');

        try {
            $info = Db::name('book_data')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['id', '=', $id]
                ])
                ->field('id,book_id,title,content')
                ->find();
            if (!$info) {
                return errorJson(lang('not found data'));
            }
            return successJson($info);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveData()
    {
        $id = input('id', 0, 'intval');
        $book_id = input('book_id', 0, 'intval');
        $title = input('title', '', 'trim');
        $content = input('content', '', 'trim');

        try {
            $data = [
                'book_id' => $book_id,
                'title' => $title,
                'content' => $content,
                'embedding_title' => '',
                'state' => 0,
                'update_time' => time()
            ];
            if ($id) {
                Db::name('book_data')
                    ->where('id', $id)
                    ->update($data);
            } else {
                $data['site_id'] = self::$site_id;
                $data['create_time'] = time();
                Db::name('book_data')
                    ->insert($data);
            }
            return successJson('', '保存成功');
        } catch (\Exception $e) {
            return errorJson(text('保存失败') . ': ' . $e->getMessage());
        }
    }

    public function delData()
    {
        $id = input('id', 0, 'intval');
        try {
            Db::name('book_data')
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
     * 设置某条数据状态
     */
    public function setDataState()
    {
        $id = input('id', 0, 'intval');
        $state = input('state', 0, 'intval');
        try {
            if ($state === 1) {
                $data = Db::name('book_data')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->find();
                $embedding_title = getEmbedding(self::$site_id, $data['title']);
                Db::name('book_data')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update([
                        'embedding_title' => $embedding_title,
                        'state' => $state
                    ]);
            } else {
                Db::name('book_data')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['id', '=', $id]
                    ])
                    ->update([
                        'state' => $state
                    ]);
            }

            return successJson('', '操作成功');
        } catch (\Exception $e) {
            return errorJson('操作失败：' . $e->getMessage());
        }
    }

    private function startTrain($minId, $maxId)
    {
        // $minId = input('minId', 0, 'intval');
        // $maxId = input('maxId', $minId, 'intval');
        $taskUrl = 'https://' . $_SERVER['HTTP_HOST'] . '/admin.php/book/startTrainAsync';
        $this->httpRequest($taskUrl, [
            'minId' => $minId,
            'maxId' => $maxId
        ]);
        exit;
    }

    /**
     * 异步任务
     */
    public function startTrainAsync()
    {
        ignore_user_abort();
        set_time_limit(600);

        $minId = input('minId', 0, 'intval');
        $maxId = input('maxId', $minId, 'intval');
        $ids = Db::name('book_data')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 0],
                ['id', 'between', [$minId, $maxId]]
            ])
            ->column('id');
        foreach ($ids as $id) {
            $data = Db::name('book_data')
                ->where('id', $id)
                ->find();
            if ($data['state'] && !empty($data['embedding_title'])) {
                continue;
            }
            if (!empty($data['title'])) {
                $embedding_title = getEmbedding(self::$site_id, $data['title']);
                Db::name('book_data')
                    ->where([
                        ['id', '=', $id]
                    ])
                    ->update([
                        'embedding_title' => $embedding_title,
                        'state' => 1
                    ]);
            }
        }
        echo '训练完成';
    }

    /**
     * 导入知识库excel
     */
    public function importData()
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

        $minId = Db::name('book_data')
            ->where([
                ['site_id', '=', self::$site_id]
            ])
            ->max('id');
        $maxId = $minId;

        //循环读取excel表格，整合成数组。如果是不指定key的二维，就用$data[i][j]表示。
        $success = 0;
        for ($j = 1; $j <= $highestRow; $j++) {
            $book_title = trim($sheet->getCell("A" . $j)->getValue());
            #1.判断有没有表头
            if ($book_title == '知识库名称') {
                continue;
            }
            $title = trim($sheet->getCell("B" . $j)->getValue());
            $content = trim($sheet->getCell("C" . $j)->getValue());
            if (empty($title) || empty($content)) {
                continue;
            }

            #2.检查有没有重复内容
            $info = Db::name('book_data')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['title', '=', $title],
                    ['content', '=', $content]
                ])
                ->find();
            if ($info) {
                continue;
            }

            #3.获取类型id，如果没有则插入一条新的
            $book_id = Db::name('book')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['title', '=', $book_title]
                ])
                ->value('id');
            if (!$book_id) {
                $book_id = Db::name('book')
                    ->insertGetId([
                        'site_id' => self::$site_id,
                        'title' => $book_title,
                        'weight' => 100,
                        'state' => 1,
                        'create_time' => time()
                    ]);
            }
            $rs = Db::name('book_data')
                ->insertGetId([
                    'site_id' => self::$site_id,
                    'book_id' => $book_id,
                    'title' => $title,
                    'content' => $content,
                    'create_time' => time()
                ]);

            if ($rs !== false) {
                $maxId = $rs;
                $success++;
            }
        }
        if ($success == $lines) {
            $message = text('已全部导入');
        } else {
            $message = text('导入成功') . $success . text('条记录');
        }
        $this->startTrain($minId, $maxId);
        return successJson([
            'maxId' => $maxId,
            'minId' => $minId,
        ], $message);
    }

    private function httpRequest($url, $post = '')
    {
        $token = session_id();
        $header = [
            'x-token: ' . $token ?? ''
        ];
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 3);
        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        }
        curl_exec($ch);
        curl_close($ch);
    }
}
