<?php

namespace app\admin\controller;

use think\facade\Db;

class Ai extends Base
{
    public function getAiList()
    {
        $guoneiList = [
            ['name' => 'azure_openai3', 'title' => 'Azure GPT-3.5'],
            ['name' => 'azure_openai4', 'title' => 'Azure GPT-4'],
            ['name' => 'wenxin', 'title' => '文心一言'],
            ['name' => 'wenxin4', 'title' => '文心一言4.0'],
            ['name' => 'xunfei', 'title' => '讯飞星火'],
            ['name' => 'tongyi', 'title' => '通义千问'],
            ['name' => 'hunyuan', 'title' => '腾讯混元'],
            ['name' => 'zhipu', 'title' => '智普AI'],
            ['name' => 'lxai', 'title' => '灵犀AI'],
            ['name' => 'minimax', 'title' => 'MiniMax'],
        ];
        $guowaiList = [
            ['name' => 'openai3', 'title' => 'GPT-3.5'],
            ['name' => 'openai4', 'title' => 'GPT-4'],
            ['name' => 'claude2', 'title' => 'Claude2'],
        ];
        $localList = [
            ['name' => 'chatglm', 'title' => 'ChatGLM'],
            ['name' => 'openllm', 'title' => 'OpenLLM'],
            ['name' => 'localai', 'title' => 'LocalAI']
        ];
        $aiSetting = Db::name('ai')
            ->where('site_id', self::$site_id)
            ->find();
        foreach ($guoneiList as &$v) {
            $v['status'] = empty($aiSetting[$v['name']]) ? 0 : 1;
        }
        foreach ($guowaiList as &$v) {
            $v['status'] = empty($aiSetting[$v['name']]) ? 0 : 1;
        }
        foreach ($localList as &$v) {
            $v['status'] = empty($aiSetting[$v['name']]) ? 0 : 1;
        }

        return successJson([
            'guonei' => $guoneiList,
            'guowai' => $guowaiList,
            'local' => $localList
        ]);
    }

    /**
     * 取单个AI设置
     */
    public function getAiSetting()
    {
        try {
            $name = input('name', '', 'trim');
            $setting = getAiSetting(self::$site_id, $name);
            $engines = Db::name('engine')
                ->where([
                    ['type', '=', $name],
                    ['state', '=', 1]
                ])
                ->field('title,name')
                ->select()->toArray();
            return successJson([
                'setting' => $setting,
                'engines' => $engines
            ]);
        } catch (\Exception $e) {
            return errorJson($e->getMessage());
        }
    }

    public function saveAiSetting()
    {
        $name = input('name', '', 'trim');
        $data = input('data', '', 'trim');
        if (!in_array($name, ['wenxin', 'wenxin4', 'azure_openai3', 'azure_openai4', 'xunfei', 'tongyi', 'hunyuan', 'zhipu', 'lxai', 'chatglm', 'minimax', 'openai3', 'openai4', 'claude2', 'openllm', 'localai'])) {
            return errorJson('参数错误');
        }
        $aiSetting = Db::name('ai')
            ->where('site_id', self::$site_id)
            ->find();
        if (!$aiSetting) {
            Db::name('ai')
                ->insert([
                    'site_id' => self::$site_id
                ]);
        }
        Db::name('ai')
            ->where('site_id', self::$site_id)
            ->update([
                $name => $data
            ]);

        return successJson('', '保存成功');
    }

    /**
     * 清除AI设置
     */
    public function clearAiSetting()
    {
        $name = input('name', '', 'trim');

        Db::name('ai')
            ->where([
                ['site_id', '=', self::$site_id]
            ])
            ->update([
                $name => ''
            ]);
        return successJson('', '清除成功');
    }
}
