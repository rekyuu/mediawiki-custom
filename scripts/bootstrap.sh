#! /bin/sh

chown -R www-data:www-data /var/www/html/images/
chmod -R 755 /var/www/html/images/

php-fpm &
nginx -g "daemon off;"