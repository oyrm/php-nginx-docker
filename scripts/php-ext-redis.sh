#!/bin/bash
yum install -y openssl pcre-devel pcre2-devel

LIB_REDIS_VERSION="5.3.7"
#RUN wget https://codeload.github.com/phpredis/phpredis/tar.gz/$LIB_REDIS_VERSION -O ~/phpredis-$LIB_REDIS_VERSION.tar.gz
cd /root/src
tar xvf redis-$LIB_REDIS_VERSION.tgz
cd redis-$LIB_REDIS_VERSION
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make -j$(nproc)
make install

cat > /usr/local/php/etc/conf.d/ext-redis.ini<<EOF
[redis]
extension=redis.so
EOF