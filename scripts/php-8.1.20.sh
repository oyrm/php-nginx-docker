#!/bin/bash
yum install -y flex libxml2-devel libxslt-devel sqlite-devel bzip2 bzip2-devel libzip libzip-devel libcurl-devel libsodium libsodium-devel \
              libpng-devel libjpeg-devel gd-devel krb5-devel freetype freetype-devel libmcrypt libmcrypt-devel bison \
              readline readline-devel libxslt libxslt-devel pcre-devel pcre2-devel postgresql-devel libargon2 libargon2-devel \
              gmp gmp-devel libicu-devel libxslt-devel openssl openssl-devel libsqlite3x-devel
# 安装oniguruma
cd /root/src
tar xvf onig-6.9.8.tar.gz
cd onig-6.9.8
./configure --prefix=/usr
make -j$(nproc)
make install
# PHP编译
cd /root/src
tar xvf php-8.1.20.tar.gz
cd php-8.1.20
./configure \
--prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-config-file-scan-dir=/usr/local/php/etc/conf.d \
--with-fpm-user=www \
--with-fpm-group=www \
--with-curl \
--with-jpeg  \
--with-xpm  \
--with-libxml \
--with-freetype \
--with-gettext \
--with-kerberos \
--with-libdir=lib64 \
--with-openssl \
--with-mysqli \
--with-pdo-mysql  \
--with-pdo-sqlite \
--with-pgsql \
--with-pdo-pgsql \
--with-mhash \
--with-ldap-sasl \
--with-xsl \
--with-zlib \
--with-bz2 \
--with-zip \
--with-iconv \
--with-password-argon2 \
--with-sodium \
--with-gmp \
--with-readline \
--enable-fpm \
--enable-pdo \
--enable-gd \
--enable-bcmath \
--enable-mbregex \
--enable-mbstring \
--enable-pcntl \
--enable-shmop \
--enable-exif \
--enable-soap \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-xml \
--enable-cli \
--enable-intl \
--enable-calendar \
--enable-static \
--enable-mysqlnd \
--enable-fileinfo \
--enable-ftp \
--enable-filter \
--enable-shared \
--enable-opcache \
--enable-re2c-cgoto
make -j$(nproc)
make install
cp php.ini-production /usr/local/php/etc/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
mkdir -p /usr/local/php/etc/conf.d/
rm -rf /usr/local/php/bin/phpdbg
# php.ini 参数优化
sed -i 's,expose_php = On,expose_php = Off,g' /usr/local/php/etc/php.ini
sed -i 's,max_execution_time = 30,max_execution_time = 300,g' /usr/local/php/etc/php.ini
sed -i 's,max_input_time = 60,max_input_time = 300,g' /usr/local/php/etc/php.ini
sed -i 's,memory_limit = 128M,memory_limit = 256M,g' /usr/local/php/etc/php.ini
sed -i 's,post_max_size = 8M,post_max_size = 128M,g' /usr/local/php/etc/php.ini
sed -i 's,upload_max_filesize = 2M,uupload_max_filesize = 256M,g' /usr/local/php/etc/php.ini
sed -i 's,;date.timezone =,date.timezone = Asia/Shanghai,g' /usr/local/php/etc/php.ini
sed -i 's,display_errors = Off,display_errors = On,g' /usr/local/php/etc/php.ini
# php-fpm www.conf 参数优化
sed -i 's,pm = dynamic,pm = static,g' /usr/local/php/etc/php-fpm.d/www.conf
sed -i 's,pm.max_children = 5,pm.max_children = 30,g' /usr/local/php/etc/php-fpm.d/www.conf
ln -s /usr/local/php/bin/php /usr/bin/php