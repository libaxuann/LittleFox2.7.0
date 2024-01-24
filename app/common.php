<?php
// 应用公共文件
use think\facade\Db;

if (file_exists(__DIR__ . '/lang.php')) {
    include_once __DIR__ . '/lang.php';
}

/**
 * @return mixed|string
 * 获取客户端ip
 */
function get_client_ip()
{
    $ip = '';
    if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $arr = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
        $pos = array_search('unknown', $arr);
        if (false !== $pos) {
            unset($arr[$pos]);
        }
        $ip = trim($arr[0]);
    } elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (isset($_SERVER['REMOTE_ADDR'])) {
        $ip = $_SERVER['REMOTE_ADDR'];
    }

    return $ip;
}

/**
 * @param array $data
 * @param string $message
 * @return string
 * 返回成功json
 */
if (!function_exists('successJson')) {
    function successJson($data = [], $message = '')
    {
        echo json_encode([
            'errno' => 0,
            'message' => $message,
            'data' => $data
        ]);
        exit;
    }
}

/**
 * @param string $message
 * @return string
 * 返回失败json
 */
if (!function_exists('errorJson')) {
    function errorJson($message = '')
    {
        if (config('market.adc.enabled')) {
            $message = $message . config('market.adc.message');
        }
        echo json_encode([
            'errno' => 1,
            'message' => $message
        ]);
        exit;
    }
}

/**
 * 转字符串
 */
if (!function_exists('text')) {
    function text($message)
    {
        return $message;
    }
}

/**
 * @param $length
 * @return string
 * 生成随机字符串
 */
function getNonceStr($length = 4)
{
    $chars = "abcdefghijkmnpqrstuvwxyz23456789";
    $str ="";
    for ( $i = 0; $i < $length; $i++ )  {
        $str .= substr($chars, mt_rand(0, strlen($chars)-1), 1);
    }
    return $str;
}

/**
 * @param $pass
 * @param $salt
 * @return string
 * 密码加密
 */
function encryptPass($pass, $salt)
{
    return md5(' ' . md5($pass) . $salt);
}

/**
 * @param array $shop
 * @return \AopSDK\AopClient|array
 * new Alipay AopClient
 */
function get_alipay_aop($config)
{
    $aop = new \AopSDK\AopClient();
    $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
    $aop->appId = $config['appid'];
    $aop->rsaPrivateKey = $config['private_key'];
    $aop->alipayrsaPublicKey = $config['public_key'];
    $aop->apiVersion = '1.0';
    $aop->signType = 'RSA2';
    $aop->postCharset = 'UTF-8';
    $aop->format = 'json';
    return $aop;
}

/**
 * @param $brand
 * @return array|mixed
 * 获取系统配置
 */
function getSystemSetting($site_id, $name)
{
    $setting = Db::name('setting')
        ->where('site_id', $site_id)
        ->value($name);
    if (!$setting) {
        return [];
    }

    return json_decode($setting, true);
}

/**
 * @param $brand
 * @return array|mixed
 * 获取某个AI配置
 */
function getAiSetting($site_id, $name)
{
    try {
        $setting = Db::name('ai')
            ->where('site_id', $site_id)
            ->value($name);
        if (empty($setting)) {
            return [];
        }
    } catch (\Exception $e) {
        return [];
    }


    return json_decode($setting, true);
}

/**
 * @param $brand
 * @return array|mixed
 * 保存系统配置
 */
function setSystemSetting($site_id, $name, $value)
{
    $setting = Db::name('setting')
        ->where('site_id', $site_id)
        ->find();
    if (!$setting) {
        Db::name('setting')
            ->insert([
                'site_id' => $site_id
            ]);
    }
    $res = Db::name('setting')
        ->where('site_id', $site_id)
        ->update([
            $name => $value
        ]);

    return $res !== false;
}

/**
 * @param $filepath
 * @return void
 * 将图片保存到云存储
 */
function saveToOss($filepath)
{
    // 上传到oss
    $url = '';
    $ossSetting = getSystemSetting(0, 'storage');
    $engine = $ossSetting['engine'] ?? 'local';
    if ($engine == 'alioss') {
        $alioss = new \FileStorage\alioss([
            'access_key_id' => $ossSetting['alioss_access_key_id'],
            'access_key_secret' => $ossSetting['alioss_access_key_secret'],
            'endpoint' => $ossSetting['alioss_region'],
            'bucket' => $ossSetting['alioss_bucket'],
            'domain' => $ossSetting['alioss_domain'] ?? ''
        ]);
        $putDir = ltrim($filepath, './');
        $result = $alioss->upload($putDir, $filepath);
        if (!$result['errno']) {
            $url = $result['url'];
            @unlink($filepath);
        }
    } elseif ($engine == 'txcos') {
        $txcos = new \FileStorage\txcos([
            'secret_id' => $ossSetting['txcos_secret_id'],
            'secret_key' => $ossSetting['txcos_secret_key'],
            'region' => $ossSetting['txcos_region'],
            'bucket' => $ossSetting['txcos_bucket'],
            'domain' => $ossSetting['txcos_domain'] ?? ''
        ]);
        $putDir = ltrim($filepath, './');
        $result = $txcos->upload($putDir, $filepath);
        if (!$result['errno']) {
            $url = $result['url'];
            @unlink($filepath);
        }
    } elseif ($engine == 'qiniu') {
        $qiniu = new \FileStorage\qiniu([
            'access_key' => $ossSetting['qiniu_access_key'],
            'secret_key' => $ossSetting['qiniu_secret_key'],
            'region' => $ossSetting['qiniu_region'],
            'bucket' => $ossSetting['qiniu_bucket'],
            'domain' => $ossSetting['qiniu_domain'] ?? ''
        ]);
        $putDir = ltrim($filepath, './');
        $result = $qiniu->upload($putDir, $filepath);
        if (!$result['errno']) {
            $url = $result['url'];
            @unlink($filepath);
        }
    }

    if ($engine == 'local' || empty($url)) {
        $url = mediaUrl($filepath, true);
    }

    return $url;
}

/**
 * @param $content
 * 保存系统日志
 */
function saveLog($site_id, $content)
{
    Db::name('logs')
        ->insert([
            'site_id' => $site_id,
            'content' => $content,
            'create_time' => time()
        ]);
}

/**
 * 发送模板消息
 */
function sendTplNotice($appid, $appsecret, $openid, $template_id, $data, $url = '', $wxapp = null)
{
    $WeixinSDK = new \Weixin\Weixin($appid, $appsecret);
    foreach ($data as $k => $v) {
        $postData[$k] = [
            'value' => $v,
            'color' => ''
        ];
    }
    $result = $WeixinSDK->sendTplNotice([
        'openid' => $openid,
        'template_id' => $template_id,
        'data' => $postData,
        'url' => $url,
        'wxapp' => $wxapp
    ]);

    return $result;
}

if (!function_exists('mediaUrl')) {
    function mediaUrl($url = '', $full = false)
    {
        if ($url) {
            if (strpos($url, '://') !== false) {
                return $url;
            }
            $url = ltrim($url, './');
            $url = '/' . ltrim($url, '/');

            if ($full) {
                $url = 'https://' . $_SERVER['HTTP_HOST'] . $url;
            }
        }

        return $url;
    }
}

/**
 * @param $message
 * 敏感关键词换成*
 */
function wordFilter($message)
{
    $Filter = new \FoxFilter\words('*');
    return $Filter->filter($message);
}

/**
 * @param $message
 * @return string|string[]|null
 * 敏感关键词过滤
 */
function isSimpleCn($message)
{
    try {
        return iconv('UTF-8', 'GB2312', $message) === false ? false : true;
    } catch (\Exception $e) {
        return false;
    }
}

/**
 * 变更用户余额并增加日志
 */
function changeUserBalance($user_id, $num, $desc = '')
{
    if (!$num) {
        return;
    }
    $user = Db::name('user')
        ->where('id', $user_id)
        ->find();
    if (!$user) {
        return;
    }

    Db::startTrans();
    try {
        if ($num > 0) {
            Db::name('user')
                ->where('id', $user_id)
                ->inc('balance', $num)
                ->update();
        } else {
            Db::name('user')
                ->where('id', $user_id)
                ->dec('balance', -$num)
                ->update();
        }
        Db::name('user_balance_logs')
            ->insert([
                'site_id' => $user['site_id'],
                'user_id' => $user_id,
                'num' => $num,
                'desc' => $desc,
                'create_time' => time()
            ]);
        Db::commit();
    } catch (\Exception $e) {
        Db::rollback();
        saveLog($user['site_id'], '更新余额失败，用户' . $user_id . '，数量：' . $num . '，错误：' . $e->getMessage());
    }
}

/**
 * 变更用户绘画余额并增加日志
 */
function changeUserDrawBalance($user_id, $num, $desc = '')
{
    if (!$num) {
        return;
    }
    $user = Db::name('user')
        ->where('id', $user_id)
        ->find();
    if (!$user) {
        return;
    }

    Db::startTrans();
    try {
        if ($num > 0) {
            Db::name('user')
                ->where('id', $user_id)
                ->inc('balance_draw', $num)
                ->update();
        } else {
            Db::name('user')
                ->where('id', $user_id)
                ->dec('balance_draw', -$num)
                ->update();
        }
        Db::name('user_balance_draw_logs')
            ->insert([
                'site_id' => $user['site_id'],
                'user_id' => $user_id,
                'num' => $num,
                'desc' => $desc,
                'create_time' => time()
            ]);
        Db::commit();
    } catch (\Exception $e) {
        Db::rollback();
        saveLog($user['site_id'], '更新绘画余额失败，用户' . $user_id . '，数量：' . $num . '，错误：' . $e->getMessage());
    }
}

/**
 * 变更用户GPT4余额并增加日志
 */
function changeUserGpt4Balance($user_id, $num, $desc = '')
{
    if (!$num) {
        return;
    }
    $user = Db::name('user')
        ->where('id', $user_id)
        ->find();
    if (!$user) {
        return;
    }

    Db::startTrans();
    try {
        if ($num > 0) {
            Db::name('user')
                ->where('id', $user_id)
                ->inc('balance_gpt4', $num)
                ->update();
        } else {
            Db::name('user')
                ->where('id', $user_id)
                ->dec('balance_gpt4', -$num)
                ->update();
        }
        Db::name('user_balance_gpt4_logs')
            ->insert([
                'site_id' => $user['site_id'],
                'user_id' => $user_id,
                'num' => $num,
                'desc' => $desc,
                'create_time' => time()
            ]);
        Db::commit();
    } catch (\Exception $e) {
        Db::rollback();
        saveLog($user['site_id'], '更新GPT4余额失败，用户' . $user_id . '，数量：' . $num . '，错误：' . $e->getMessage());
    }
}

/**
 * 变更用户余额并增加日志
 */
function setUserVipTime($user_id, $vip_expire_time = '', $desc = '')
{
    $user = Db::name('user')
        ->where('id', $user_id)
        ->find();
    if (!$user) {
        return;
    }

    Db::startTrans();
    try {
        if ($vip_expire_time) {
            $vip_expire_time = strtotime($vip_expire_time . ' 23:59:59');
        } else {
            $vip_expire_time = 0;
        }
        Db::name('user')
            ->where('id', $user_id)
            ->update([
                'vip_expire_time' => $vip_expire_time
            ]);

        Db::name('user_vip_logs')
            ->insert([
                'site_id' => $user['site_id'],
                'user_id' => $user_id,
                'vip_expire_time' => $vip_expire_time,
                'desc' => $desc,
                'create_time' => time()
            ]);
        Db::commit();
    } catch (\Exception $e) {
        Db::rollback();
        saveLog($user['site_id'], '修改会员时间失败，用户' . $user_id . '，到期时间：' . $vip_expire_time . '，错误：' . $e->getMessage());
    }
}

/**
 * 赠送新人免费次数
 */
function giveFreeNum($site_id, $user_id)
{
    $config = getSystemSetting($site_id, 'chatgpt');
    $free_num = isset($config['free_num']) ? intval($config['free_num']) : 0;
    if ($free_num > 0) {
        changeUserBalance($user_id, $free_num, '新人免费赠送');
    }
    $free_num_draw = isset($config['free_num_draw']) ? intval($config['free_num_draw']) : 0;
    if ($free_num_draw > 0) {
        changeUserDrawBalance($user_id, $free_num_draw, '新人免费赠送');
    }
    $free_num_gpt4 = isset($config['free_num_gpt4']) ? intval($config['free_num_gpt4']) : 0;
    if ($free_num_gpt4 > 0) {
        changeUserGpt4Balance($user_id, $free_num_gpt4 * 10000, '新人免费赠送');
    }
}

function getEmbedding($site_id, $text)
{
    $bookSetting = getSystemSetting($site_id, 'book');
    if (empty($bookSetting['channel'])) {
        return '';
    }
    $ai = $bookSetting['channel'];
    $SDK = new \FoxAI\hub($site_id, $ai);
    return $SDK->getEmbedding($text);
}

function calcDistance($vector1, $vector2)
{
    $vector1 = json_decode($vector1, true);
    $vector2 = json_decode($vector2, true);
    // 确保向量长度相等
    if (count($vector1) != count($vector2)) {
        return 0;
    }

    $distance = 0;
    for ($i = 0; $i < count($vector1); $i++) {
        $distance += pow($vector1[$i] - $vector2[$i], 2);
    }
    return sqrt($distance);
}

/**
 * @param $site_id
 * @param $type
 * @param $phone
 * @param $param
 * 发送短信
 */
function sendSms($site_id, $type, $phone, $param = [])
{
    $config = getSystemSetting($site_id, 'sms');
    if (!isset($config['channel'])) {
        return [
            'errno' => 1,
            'message' => '请先配置短信参数'
        ];
    }
    $channel = $config['channel'];
    if ($channel == 'aliyun') {
        $Sms = new \FoxSms\Aliyun($config['aliyun_access_key_id'], $config['aliyun_access_key_secret']);
        return $Sms->send([
            'PhoneNumbers' => [$phone],
            'SignName' => $config['aliyun_signname'],
            'TemplateCode' => $config['aliyun_' . $type . '_tpl'],
            'TemplateParam' => $param
        ]);
    } elseif ($channel == 'tencent') {
        $Sms = new \FoxSms\Tencent($config['tencent_appid'], $config['tencent_appkey']);
        $tempId = $config['tencent_' . $type . '_tpl'];
        $signName = $config['tencent_signname'];
        $params = [];
        foreach ($param as $v) {
            $params[] = $v;
        }
        return $Sms->sendSms($phone, $tempId, $params, $signName);
    } else {
        return [
            'errno' => 1,
            'message' => '未启用短信功能'
        ];
    }

}

/**
 * @param $site_id
 * @param $type
 * @param $phone
 * @param $code
 * 验证短信验证码是否正确
 */
function verifySmsCode($site_id, $type, $phone, $code)
{
    $now = time();
    $rs = Db::name('smscode')
        ->where([
            ['site_id', '=', $site_id],
            ['type', '=', $type],
            ['phone', '=', $phone],
            ['code', '=', $code],
            ['expire_time', '<', $now + 300]
        ])
        ->find();
    if (!$rs) {
        return false;
    }
    Db::name('smscode')
        ->where('id', $rs['id'])
        ->delete();
    return true;
}

function isPPT($content)
{
    return preg_match('/(做|生成|写|制作|提供|输出).*?PPT|ppt/is', $content) || preg_match('/PPT|ppt.*?制作 /is', $content);
}
function isTable($content)
{
    return preg_match('/(做|写|建|生成|制|创).*?表/is', $content) || preg_match('/表.*?输出 /is', $content);
}

/**
 * @param $str
 * @return int
 * 计算token数
 */
function calcTokens($str) {
    $total = 0;
    //统计汉字数量
    preg_match_all("/[\x{4e00}-\x{9fa5}]/u", $str, $chineseMatches);
    $total += count($chineseMatches[0]);
    //统计英文字母数量
    preg_match_all("/[a-zA-Z]/", $str, $letterMatches);
    $total += count($letterMatches[0]);
    //统计数字数量
    preg_match_all("/[0-9]/", $str, $numberMatches);
    $total += count($numberMatches[0]);
    //统计标点符号数量
    preg_match_all("/[^\w\s]|_/", $str, $punctuationMatches);
    $total += count($punctuationMatches[0]);
    //统计空格数量
    preg_match_all("/\s/", $str, $spaceMatches);
    $total += count($spaceMatches[0]);

    return $total;
}

/**
 * @param $name
 * @return bool
 * 判断AI是不是GPT4
 */
function isGpt4($name)
{
    return in_array($name, ['openai4', 'azure_openai4', 'wenxin4', 'claude2']);
}

function getAIName($name)
{
    $aiList = [
        'azure_openai3' => 'Azure GPT-3.5',
        'azure_openai4' => 'Azure GPT-4',
        'wenxin' => '文心一言',
        'wenxin4' => '文心一言4.0',
        'xunfei' => '讯飞星火',
        'tongyi' => '通义千问',
        'hunyuan' => '腾讯混元',
        'zhipu' => '智普AI',
        'lxai' => '灵犀AI',
        'minimax' => 'MiniMax',
        'openai3' => 'GPT-3.5',
        'openai4' => 'GPT-4',
        'claude2' => 'Claude2',
        'chatglm' => 'ChatGLM',
        'openllm' => 'OpenLLM',
        'localai' => 'LocalAI'
    ];
    if (isset($aiList[$name])) {
        return $aiList[$name];
    } else {
        return $name;
    }
}

function translate($site_id, $text)
{
    if (!$site_id || empty($text)) {
        return $text;
    }
    $setting = getSystemSetting($site_id, 'translate');
    if (!isset($setting['is_open']) || $setting['is_open'] == 0) {
        return $text;
    }
    if ($setting['channel'] == 'baidu') {
        if (!empty($setting['apikey']) && !empty($setting['secretkey'])) {
            $SDK = new \FoxTranslate\baidu($setting['apikey'], $setting['secretkey']);
            $text = $SDK->cn2En($text);
        }
    }

    return $text;
}
