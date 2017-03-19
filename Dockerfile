FROM php:7.1.3-fpm

# install nginx
ENV NGINX_VERSION 1.10.3-1~jessie

RUN apt-get update && \
    apt-get install nginx -y

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# install extensions and typecho
RUN apt-get update && \
    apt-get install libcurl4-openssl-dev sqlite3 libsqlite3-dev && \
    docker-php-ext-install pdo_mysql pdo_sqlite

ADD . /var/www/html

RUN mv nginx.conf /etc/nginx/conf.d && \
    tar -xvf 1.0.14.10.10.-release.tar.gz && \
    rm 1.0.14.10.10.-release.tar.gz && \
    mv build/* ./

EXPOSE 80

CMD ["sh", "-c", "./start.sh"]
