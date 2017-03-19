FROM php:7.1.3-fpm

# install nginx
ENV NGINX_VERSION 1.10.3-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# install extensions and typecho
RUN docker-php-ext-install pdo_mysql curl iconv json mbstring

ADD https://github.com/typecho/typecho/releases/download/v1.0-14.10.10-release/1.0.14.10.10.-release.tar.gz typecho.tar.gz

RUN tar -xvf typecho.tar.gz && \
    rm typecho.tar.gz && \
    mv build/* ./

CMD ["sh", "start.sh"]
