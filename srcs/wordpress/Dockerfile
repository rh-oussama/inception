FROM alpine:3.18

RUN apk update && \
    apk add --no-cache \
    curl \
    zip \
    php \
    mariadb-client \
    php-fpm \
    php-phar \
    php-mysqli \
    php-mbstring \
    php-iconv \
    php-session

WORKDIR /var/www/html


COPY ["conf/www.conf", "/etc/php81/php-fpm.d/www.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]