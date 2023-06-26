#!/bin/bash
yum install -y openssl pcre-devel pcre2-devel
#安装rabbitmq-c库
RABBITMQ_C_VERSION="0.11.0"
#RUN wget https://github.com/alanxz/rabbitmq-c/archive/v$RABBITMQ_C_VERSION.tar.gz -O ~/rabbitmq-c-$RABBITMQ_C_VERSION.tar.gz
cd /root/src
tar xvf rabbitmq-c-$RABBITMQ_C_VERSION.tar.gz
cd rabbitmq-c-$RABBITMQ_C_VERSION
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/librabbitmq ..
cmake --build ./
make -j$(nproc)
make install
cp -r /usr/local/librabbitmq/lib64 /usr/local/librabbitmq/lib
#安装amqp扩展
PHP_AMQP_VERSION="1.11.0"
#RUN wget https://pecl.php.net/get/amqp-$PHP_AMQP_VERSION.tgz -O ~/amqp-$PHP_AMQP_VERSION.tgz
cd /root/src
tar xvf amqp-$PHP_AMQP_VERSION.tgz
cd amqp-$PHP_AMQP_VERSION
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/librabbitmq
make -j$(nproc)
make install
cat > /usr/local/php/etc/conf.d/ext-amqp.ini<<EOF
[amqp]
extension=amqp.so
EOF