#!/bin/bash
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
yum -y install epel-release
sed -e 's|^mirrorlist=|#mirrorlist=|g' -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' -i.bak /etc/yum.repos.d/Rocky-*.repo
sed -e 's|^metalink=|#metalink=|g' -e 's|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com|g' -i.bak /etc/yum.repos.d/epel*.repo
yum clean all
yum -y autoremove
rm -rf /var/cache/yum
yum makecache
yum install -y gcc gcc-c++ make cmake autoconf automake libtool
yum install -y procps vim wget git