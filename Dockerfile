FROM php:7.1.7-fpm

ADD ./sources.list /tmp

# using 163 souces
RUN cat /tmp/sources.list > /etc/apt/sources.list

# install extensions and typecho
RUN apt-get update && \
    apt-get install libcurl4-openssl-dev sqlite3 libsqlite3-dev libpq-dev -y && \
    docker-php-ext-install pdo_mysql pdo_pgsql

WORKDIR /var/www/html/

ADD ./1.0.14.10.10.-release.tar.gz /var/www/html/
ADD ./docker-nginx.conf /var/www/html/
ADD ./utils/ /var/www/html/utils/

RUN cp -r build/* ./ && \
    rm -rf build/ && \
    chown -R www-data:www-data ./
