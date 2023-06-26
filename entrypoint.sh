#!/bin/sh
# /usr/local/php/sbin/php-fpm -F
/usr/local/php/sbin/php-fpm -D
# /usr/local/nginx/sbin/nginx -g
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf