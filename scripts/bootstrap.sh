#! /bin/sh

chown -R www-data:www-data /var/www/html/images/
chmod -R 755 /var/www/html/images/

php-fpm85 &
nginx -g "daemon off;"