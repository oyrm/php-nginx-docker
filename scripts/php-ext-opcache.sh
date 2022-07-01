#!/bin/bash

cat > /usr/local/php/etc/conf.d/ext-opcache.ini<<EOF
[opcache]
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
opcache.memory_consumption=192
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.jit=1205
opcache.jit_buffer_size=64M
EOF