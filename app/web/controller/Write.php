<?php

namespace app\web\controller;

use think\facade\Db;
class Write extends Base
{
    public function getTopicList()
    {
        $list = Db::name('write_topic')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1]
            ])
            ->order('weight desc, id asc')
            ->field('id,title')
            ->select()
            ->toArray();

        return successJson($list);
    }

    public function getPrompts()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $topic_id = input('topic_id', 'all');
        $where = [
            ['site_id', '=', self::$site_id],
            ['state', '=', 1],
            ['is_delete', '=', 0]
        ];
        if ($topic_id != 'all') {
            $where[] = ['topic_id', '=', $topic_id];
        }
        $myVotes = Db::name('write_prompts_vote')
            ->where('user_id', self::$user['id'])
            ->column('prompt_id');

        $list = Db::name('write_prompts')
            ->where($where)
            ->order('weight desc,usages desc,views desc, id asc')
            ->page($page, $pagesize)
            ->field('id,title,desc,usages,views,fake_usages,fake_views')
            ->select()->each(function ($item) use ($myVotes) {
                $item['isVote'] = in_array($item['id'], $myVotes) ? 1 : 0;
                $item['views'] = $item['views'] + $item['fake_views'];
                $item['usages'] = $item['usages'] + $item['fake_usages'];
                unset($item['fake_usages'], $item['fake_views']);
                return $item;
            })->toArray();

        $count = Db::name('write_prompts')
            ->where($where)
            ->count();

        return successJson([
            'list' => $list,
            'count' => $count
        ]);
    }

    public function getAllPrompt()
    {
        $myVotes = Db::name('write_prompts_vote')
            ->where('user_id', self::$user['id'])
            ->column('prompt_id');
        $topicList = Db::name('write_topic')
            ->where([
                ['site_id', '=', self::$site_id],
                ['state', '=', 1]
            ])
            ->field('id, title')
            ->order('weight desc, id asc')
            ->select()->each(function($topic) use ($myVotes) {
                $topic['prompts'] = Db::name('write_prompts')
                    ->where([
                        ['site_id', '=', self::$site_id],
                        ['topic_id', '=', $topic['id']],
                        ['state', '=', 1],
                        ['is_delete', '=', 0]
                    ])
                    ->order('weight desc,usages desc,views desc, id asc')
                    ->field('id,topic_id,title,desc,usages,views,fake_usages,fake_views')
                    ->select()->each(function ($item) use ($myVotes) {
                        $item['isVote'] = in_array($item['id'], $myVotes) ? 1 : 0;
                        $item['views'] = $item['views'] + $item['fake_views'];
                        $item['usages'] = $item['usages'] + $item['fake_usages'];
                        unset($item['fake_usages'], $item['fake_views']);
                        return $item;
                    })->toArray();
                return $topic;
            });

        return successJson($topicList);
    }

    public function getVotePrompts()
    {
        $page = input('page', 1, 'intval');
        $pagesize = input('pagesize', 10, 'intval');
        $where = [
            ['site_id', '=', self::$site_id],
            ['user_id', '=', self::$user['id']]
        ];

        $list = Db::name('write_prompts_vote')
            ->where($where)
            ->order('id desc')
            ->page($page, $pagesize)
            ->select()->toArray();
        $voteList = [];
        foreach ($list as $v) {
            $prompt = Db::name('write_prompts')
                ->where([
                    ['id', '=', $v['prompt_id']],
                    ['state', '=', 1]
                ])
                ->field('id,title,desc,usages,views,fake_usages,fake_views')
                ->find();
            if ($prompt) {
                $prompt['isVote'] = 1;
                $prompt['views'] = $prompt['views'] + $prompt['fake_views'];
                $prompt['usages'] = $prompt['usages'] + $prompt['fake_usages'];
                unset($prompt['fake_usages'], $prompt['fake_views']);
                $voteList[] = $prompt;
            }
        }

        $count = Db::name('write_prompts_vote')
            ->where($where)
            ->count();

        return successJson([
            'list' => $voteList,
            'count' => $count
        ]);
    }

    public function getPrompt()
    {
        $prompt_id = input('prompt_id', '', 'intval');
        $info = Db::name('write_prompts')
            ->where([
                ['site_id', '=', self::$site_id],
                ['id', '=', $prompt_id],
                ['is_delete', '=', 0]
            ])
            ->field('id,title,prompt,desc,hint,welcome,tips')
            ->find();
        if (!$info) {
            return errorJson('未找到此模型');
        }
        $info['is_ppt'] = isPPT($info['prompt']);
        $info['is_table'] = isTable($info['prompt']);
        unset($info['prompt']);
        // 点击量+1
        Db::name('write_prompts')
            ->where('id', $info['id'])
            ->inc('views', 1)
            ->update();

        return successJson($info);
    }

    public function votePrompt()
    {
        $prompt_id = input('prompt_id', '', 'intval');
        $info = Db::name('write_prompts_vote')
            ->where([
                ['site_id', '=', self::$site_id],
                ['user_id', '=', self::$user['id']],
                ['prompt_id', '=', $prompt_id]
            ])
            ->find();
        if ($info) {
            Db::name('write_prompts_vote')
                ->where([
                    ['site_id', '=', self::$site_id],
                    ['user_id', '=', self::$user['id']],
                    ['prompt_id', '=', $prompt_id]
                ])
                ->delete();
            // 收藏量-1
            Db::name('write_prompts')
                ->where('id', $prompt_id)
                ->dec('votes', 1)
                ->update();
            return successJson('', '已取消收藏');
        } else {
            Db::name('write_prompts_vote')
                ->insert([
                    'site_id' => self::$site_id,
                    'user_id' => self::$user['id'],
                    'prompt_id' => $prompt_id,
                    'create_time' => time()
                ]);
            // 收藏量+1
            Db::name('write_prompts')
                ->where('id', $prompt_id)
                ->inc('votes', 1)
                ->update();
            return successJson('', '收藏成功');
        }
    }

    /**
     * 获取消息历史记录
     */
    public function getHistoryMsg()
    {
        $prompt_id = input('prompt_id', 0, 'intval');
        $list = Db::name('msg_write')
            ->where([
                ['user_id', '=', self::$user['id']],
                ['prompt_id', '=', $prompt_id],
                ['is_delete', '=', 0]
            ])
            ->field('message,response')
            ->order('id desc')
            ->limit(10)
            ->select()->toArray();
        $msgList = [];
        $list = array_reverse($list);
        foreach ($list as $v) {
            $msgList[] = [
                'user' => '我',
                'message' => $v['message']
            ];
            $msgList[] = [
                'user' => 'AI',
                'message' => $v['response']
            ];
        }
        /*if (empty($msgList)) {
            $prompt = Db::name('write_prompts')
                ->where([
                    ['id', '=', $prompt_id],
                    ['is_delete', '=', 0]
                ])
                ->field('hint,welcome')
                ->find();
            if ($prompt) {
                if (!empty($prompt['welcome'])) {
                    $msgList[] = [
                        'user' => 'AI',
                        'message' => formatMsg($prompt['welcome'])
                    ];
                } else {
                    $msgList[] = [
                        'user' => 'AI',
                        'message' => formatMsg('提示：' . $prompt['hint'])
                    ];
                }
            }
        }*/

        return successJson($msgList);
    }
}
