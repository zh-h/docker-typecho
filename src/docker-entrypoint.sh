#!/bin/sh
cd /var/www/html/
tar -xvf /var/www/src/1.0.14.10.10.-release.tar.gz
cp -r build/* ./
rm -rf build/
chown -R www-data:www-data ./
php-fpm