#!/bin/bash
yum install -y openssl pcre-devel pcre2-devel
PHP_MONGODB_VERSION="1.16.1"
cd /root/src
tar xvf mongodb-$PHP_MONGODB_VERSION.tgz
cd mongodb-$PHP_MONGODB_VERSION
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make -j$(nproc)
make install
cat > /usr/local/php/etc/conf.d/ext-mongodb.ini<<EOF
[mongodb]
extension=mongodb.so
EOF