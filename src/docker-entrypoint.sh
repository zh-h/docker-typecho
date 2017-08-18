#!/bin/sh
cd /var/www/html/
# extract source files
tar -xvf /var/www/src/1.0.14.10.10.-release.tar.gz
cp -r build/* ./
rm -rf build/
cp -r /var/www/src/utils/ ./
chown -R www-data:www-data ./
# setting base authentication
htpasswd -b -c /var/www/src/.htpasswd $AUTH_USER $AUTH_PASSWORD
php-fpm