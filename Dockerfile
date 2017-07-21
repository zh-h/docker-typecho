FROM php:7.1.7-fpm

# install extensions and typecho
RUN apt-get update && \
    apt-get install libcurl4-openssl-dev sqlite3 libsqlite3-dev && \
    docker-php-ext-install pdo_mysql

WORKDIR /var/www/html/

ADD ./1.0.14.10.10.-release.tar.gz /var/www/html/
ADD ./docker-nginx.conf /var/www/html/

RUN cp -r build/* ./ && \
    rm -rf build/ && \
    chown -R www-data:www-data ./
