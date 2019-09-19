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