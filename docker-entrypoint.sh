#!/bin/sh
if [ ! -d "./install"]; then 
    tar -xvf 1.0.14.10.10.-release.tar.gz
    cp -r build/* ./
    rm -rf build/
fi 
chown -R www-data:www-data .
php-fpm