<?php
namespace FoxQrcode;

class code
{
    public function __construct()
    {
        require('phpqrcode/qrlib.php');
    }

    /**
     * 生成普通二维码
     * @param string $url 生成url地址
     * @param bool $outfile
     * @param int $size
     * @param string $evel
     * @return string $url
     */
    public function png($content, $filepath = '', $size = 5, $evel = 'H')
    {
        if (!is_dir(dirname($filepath))) {
            @mkdir(dirname($filepath), 0775, true);
        }

        \QRcode::png($content, $filepath, $evel, $size, 2);

        return $filepath;
    }
}