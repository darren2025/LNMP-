#!/bin/bash
#创建一个src目录方便管理包
mkdir /src
cd /src
yum update
yum -y install gcc pcre-devel openssl-devel zlib-devel
wget http://nginx.org/download/nginx-1.16.1.tar.gz
wget https://raw.githubusercontent.com/darren2025/LNMP-/master/nginx
wget https://raw.githubusercontent.com/darren2025/LNMP-/master/nginx.service
cp nginx /etc/init.d
cp nginx nginx.service /usr/lib/systemd/system
tar zxf nginx-1.16.1.tar.gz
#添加用户和用户组 设置程序启动的用户
groupadd www
useradd -M -g www -s /usr/sbin/nologin www
#编译安装过程
cd nginx-1.16.1
./configure --user=www --group=www  \
--prefix=/usr/local/nginx \
--with-http_stub_status_module \
--with-http_ssl_module \
#编译 && 安装
make && make install
systemctl daemon-reload
service nginx start
#切换会src目录
cd /src

#安装PHP
yum install -y gcc-c++ libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install -y mod_php72w php72w-mysqlnd php72w-cli php72w-dev php72w-fpm php72w-gd php72w-pdo  php72w-mbstring php72w-opcache php72w-devel.x86_64

#安装mysql
wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm 
yum localinstall mysql57-community-release-el7-8.noarch.rpm

#安装MySQL数据库 约190M左右
yum install -y mysql-community-server
#启动数据库
systemctl start mysqld
# 查看初始密码
grep 'temporary password' /var/log/mysqld.log

#如果需要安装密码在这里

