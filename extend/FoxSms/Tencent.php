<?php

namespace FoxSms;

use \Qcloud\Sms\SmsSingleSender;

class Tencent
{
    private static $appid = '';
    private static $appkey = '';

    public function __construct($appid = '', $appkey = '')
    {
        self::$appid = $appid;
        self::$appkey = $appkey;
    }

    public function sendSms($phoneNumber, $templId, $params, $sign = '')
    {
        $nationCode = 86;
        $smsSender = new SmsSingleSender(self::$appid, self::$appkey);
        $result = $smsSender->sendWithParam($nationCode, $phoneNumber, $templId, $params, $sign);
        $result = json_decode($result, true);
        if ($result['result'] != 0) {
            return [
                'errno' => 1,
                'message' => $result['errmsg']
            ];
        }

        return [
            'errno' => 0
        ];
    }
}