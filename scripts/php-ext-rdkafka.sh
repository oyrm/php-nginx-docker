#!/bin/bash
yum install -y openssl pcre-devel pcre2-devel librdkafka-devel lz4 lz4-devel
LIBRDKAFKA_VERSION="2.1.1"
cd /root/src
tar xvf librdkafka-$LIBRDKAFKA_VERSION.tar.gz
cd librdkafka-$LIBRDKAFKA_VERSION
./configure
make -j$(nproc)
make install
PHP_RDKAFKA_VERSION="6.0.3"
cd /root/src
tar xvf rdkafka-$PHP_RDKAFKA_VERSION.tgz
cd rdkafka-$PHP_RDKAFKA_VERSION
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make -j$(nproc)
make install
cat > /usr/local/php/etc/conf.d/ext-rdkafka.ini<<EOF
[rdkafka]
extension=rdkafka.so
EOF