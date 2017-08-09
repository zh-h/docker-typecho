FROM php:7.1.7-fpm

ADD ./sources.list /tmp

# using 163 souces
RUN cat /tmp/sources.list > /etc/apt/sources.list

# install extensions and typecho
RUN apt-get update && \
    apt-get install libcurl4-openssl-dev sqlite3 libsqlite3-dev libpq-dev -y && \
    docker-php-ext-install pdo_mysql pdo_pgsql

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN sed -i 's/\r//g' /docker-entrypoint.sh

VOLUME /var/www/html/

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]

