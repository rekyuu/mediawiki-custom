#! /bin/sh

chown -R www-data:www-data /var/www/html/images/
chmod -R 755 /var/www/html/images/

php-fpm84 --fpm-config /usr/local/etc/php-fpm.conf --prefix /usr/local &
nginx -g "daemon off;"