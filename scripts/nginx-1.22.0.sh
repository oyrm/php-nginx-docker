#!/bin/bash

#安装其他依赖
yum -y install pcre pcre-devel pcre2-devel zlib zlib-devel openssl openssl-devel bzip2 gd gd-devel

#安装jemalloc内存分配器
LIB_JEMALLOC_VERSION="5.3.0"
cd /root/src
tar jxvf jemalloc-$LIB_JEMALLOC_VERSION.tar.bz2
cd jemalloc-$LIB_JEMALLOC_VERSION
./autogen.sh
make -j$(nproc)
make install
echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
ldconfig

#------------NGINX安裝准备-----------
#需要用到的openssl
LIB_OPENSSL_VERSION="1.1.1p"
cd /root/src
tar zxvf openssl-$LIB_OPENSSL_VERSION.tar.gz
#需要用到的pcre
LIB_PCRE_VERSION="10.40"
cd /root/src
tar zxvf pcre2-$LIB_PCRE_VERSION.tar.gz
#需要用到的zlib
LIB_ZLIB_VERSION="1.2.12"
cd /root/src
tar zxvf zlib-$LIB_ZLIB_VERSION.tar.gz

#安裝nginx
NGINX_VERSION="1.22.0"
#RUN wget https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -O ~/nginx-$NGINX_VERSION.tar.gz
cd /root/src
tar zxvf nginx-$NGINX_VERSION.tar.gz
cd nginx-$NGINX_VERSION
./configure \
    --prefix=/usr/local/nginx \
    --user=www \
    --group=www \
    --error-log-path=/data/wwwlogs/nginx_error.log \
    --http-log-path=/data/wwwlogs/nginx_access.log \
    --pid-path=/var/run/nginx.pid \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-http_image_filter_module \
    --with-stream \
    --with-stream_ssl_module \
    --with-file-aio \
    --with-pcre-jit \
    --with-ld-opt=-ljemalloc \
    --with-openssl=/root/src/openssl-$LIB_OPENSSL_VERSION \
    --with-pcre=/root/src/pcre2-$LIB_PCRE_VERSION \
    --with-zlib=/root/src/zlib-$LIB_ZLIB_VERSION

make -j$(nproc)
make install

ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx