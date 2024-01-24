<?php

return [
    'curent' => json_decode(file_get_contents('./version.json'), true),
    'history' => json_decode(file_get_contents('./history.json'), true)
];