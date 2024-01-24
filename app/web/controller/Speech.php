<?php

namespace app\web\controller;

use think\facade\Db;
use think\facade\Filesystem;

class Speech extends Base
{
    private static $SpeechSDK = null;

    public function __construct()
    {
        parent::__construct();
        $setting = getSystemSetting(self::$site_id, 'speech');
        if (empty($setting['is_open'])) {
            return errorJson('未启用语音功能');
        }
        if ($setting['channel'] == 'baidu') {
            self::$SpeechSDK = new \FoxAudio\baidu($setting['baidu_apikey'], $setting['baidu_secretkey'], [
                'spd' => intval($setting['baidu_spd'] ?? 5),
                'pit' => intval($setting['baidu_pit'] ?? 5),
                'per' => intval($setting['baidu_per'] ?? 0),
                'cuid' => self::$user['id']
            ]);
        } elseif ($setting['channel'] == 'openai3') {
            $aiSetting = getAiSetting(self::$site_id, 'openai3');
            if (empty($aiSetting)) {
                return errorJson('请先配置AI通道');
            }
            if ($aiSetting['channel'] == 'api2d') {
                $apiKey = $this->getApiKey('api2d');
            } else {
                $apiKey = $this->getApiKey('openai3');
            }
            self::$SpeechSDK = new \FoxAudio\openai($apiKey, [
                'voice' => $setting['openai3_voice'],
                'model' => $setting['openai3_model'] ?? 'tts-1-hd'
            ]);
            $diyhost = $aiSetting['diyhost'];
            if ($diyhost == 'https://api.openai.com') {
                $apiSetting = getSystemSetting(0, 'api');
                if ($apiSetting['channel'] == 'agent' && $apiSetting['agent_host']) {
                    $diyhost = rtrim($apiSetting['agent_host'], '/');
                }
            }
            self::$SpeechSDK->setApiHost($diyhost);
        }
    }

    /**
     * 文字转音频
     */
    public function text2Audio()
    {
        try {
            $text = input('text', '', 'trim');
            $result = self::$SpeechSDK->text2Audio($text);
            if (is_array($result) && $result['errno'] > 0) {
                return errorJson($result['message']);
            }
            $dir = './upload/audio/' . date('Ymd');
            if (!is_dir($dir)) {
                @mkdir($dir, 0755, true);
            }
            $path = $dir . '/' . md5($text . uniqid()) . '.mp3';
            file_put_contents($path, $result);
            $url = saveToOss($path);
            return successJson($url);
        } catch (\Exception $e) {
            $message = $e->getMessage();
            if (strpos($message, 'Unauthorized') !== false) {
                $message = 'apiKey或secretKey不正确';
            }
            return errorJson($message);
        }

    }

    /**
     * 音频转文字
     */
    public function audio2Text()
    {
        try {
            $file = request()->file('file');
            $path = Filesystem::disk('public')->putFile('record', $file, 'uniqid');
            $ext = strrchr($path, '.');
            if (!in_array($ext, ['.wav'])) {
                @unlink('./upload/' . $path);
                return errorJson('录音格式不正确');
            }
            // 语音转文字
            $result = self::$SpeechSDK->audio2Text('./upload/' . $path);
            if (empty($result)) {
                return errorJson('没有识别到内容');
            }
            if (is_array($result) && $result['errno'] > 0) {
                return errorJson($result['message']);
            }
            // 上传到oss
            $path = saveToOss('upload/' . $path);
            return successJson([
                'audio' => $path,
                'text' => $result
            ]);
        } catch (\Exception $e) {
            $message = $e->getMessage();
            if (strpos($message, 'Unauthorized') !== false) {
                $message = 'apiKey或secretKey不正确';
            }
            return errorJson($message);
        }
    }

    /**
     * 从key池里取回一个key
     */
    private function getApiKey($type)
    {
        $rs = Db::name('keys')
            ->where([
                ['site_id', '=', self::$site_id],
                ['type', '=', $type],
                ['state', '=', 1]
            ])
            ->order('last_time asc, id asc')
            ->find();
        if (!$rs) {
            return errorJson('key已用尽，请等待平台处理');
        }
        return $rs['key'];
    }
}