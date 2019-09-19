#!/bin/bash
#安装nginx
yum -y install gcc pcre-devel openssl-devel zlib-devel
yum -y install libxml2-devel libjpeg-devel libpng-devel freetype-devel
wget https://raw.githubusercontent.com/darren2025/LNMP-/master/nginx
wget https://raw.githubusercontent.com/darren2025/LNMP-/master/nginx.service
wget https://raw.githubusercontent.com/darren2025/LNMP-/master/nginx-1.16.1.tar.gz
wget https://raw.githubusercontent.com/darren2025/LNMP-/master/php-7.3.2.tar.gz
cp nginx /etc/init.d
cp nginx nginx.service /usr/lib/systemd/system
chmod +x nginx /etc/init.d/nginx
#安装PHP
#解压进入解压目录
tar -zxvf php-7.3.2.tar.gz
cd php-7.3.2
#配置
./configure --prefix=/usr/local/php_nginx \
--with-config-file-path=/usr/local/php/etc \
--with-fpm-user=www \
--with-fpm-group=www \
--with-pdo-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-freetype-dir \
--with-gd \
--with-zlib \
--with-libxml-dir \
--with-jpeg-dir \
--with-png-dir \
--enable-mbstring=all \
--enable-mbregex \
--enable-shared \
--enable-fpm \
--without-pear
make && make install
cp /usr/local/php_nginx/etc/php-fpm.conf.default /usr/local/php_nginx/etc/php-fpm.conf
cp /usr/local/php_nginx/etc/php-fpm.d/www.conf.default /usr/local/php_nginx/etc/php-fpm.d/www.conf
cp php.ini-development /usr/local/php_nginx/etc/php.ini
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on
echo 'PATH=/usr/local/php/bin:$PATH' >> /etc/profile
source /etc/profile
service php-fpm start
#添加开机自启
systemctl enable php-fpm.service
#安装nginx
#添加用户和用户组 设置程序启动的用户
groupadd www
useradd -M -g www -s /usr/sbin/nologin www
#解压源码包
tar -zxvf nginx-1.16.1.tar.gz
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
#添加开机自启
systemctl enable nginx.service
#添加防火墙规则
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
service iptables save 
service iptables restart 


v=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
 if [ $v -eq 6 ]; then
#centos6
#下载文件
wget https://raw.githubusercontent.com/darren2025/mysql5.1-5.6/master/install_mysql.sh
#给予权限
chmod +x install_mysql.sh
#执行:
sh install_mysql.sh
#开启自启
chkconfig --add mysqld
chkconfig --level 35 mysqld on
#初始化数据库
mysql_secure_installation
fi
 
#  centos-7:
 
if [ $v -eq 7 ]; then
 
#安装mysql
#下载
yum install -y mariadb-server
#启动
systemctl start mariadb.service
#添加开机启动
systemctl enable mariadb.service
#初始化数据库
mysql_secure_installation
fi











