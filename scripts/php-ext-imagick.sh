#!/bin/bash
yum install -y openssl pcre-devel pcre2-devel

#安装ImageMagic
IMAGEMAGIC_VERSION="7.1.0-28"
#RUN wget http://www.imagemagick.org/download/ImageMagick-$IMAGEMAGIC_VERSION.tar.gz -O ~/ImageMagick-$IMAGEMAGIC_VERSION.tar.gz
cd /root/src
tar xvf ImageMagick-$IMAGEMAGIC_VERSION.tar.gz
cd ImageMagick-$IMAGEMAGIC_VERSION
./configure --prefix=/usr/local/imagemagick
make -j$(nproc)
make install
/usr/local/imagemagick/bin/convert -version

#安装imagick扩展
PHP_IMAGICK_VERSION="3.7.0"
#RUN wget https://pecl.php.net/get/imagick-$PHP_IMAGICK_VERSION.tar.gz -O ~/imagick-$PHP_IMAGICK_VERSION.tar.gz
cd /root/src
tar xvf imagick-$PHP_IMAGICK_VERSION.tgz
cd imagick-$PHP_IMAGICK_VERSION
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-imagick=/usr/local/imagemagick
make -j$(nproc)
make install

cat > /usr/local/php/etc/conf.d/ext-imagick.ini<<EOF
[imagick]
extension=imagick.so
EOF