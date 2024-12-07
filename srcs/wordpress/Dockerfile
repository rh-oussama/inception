FROM alpine:3.18

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    curl zip php81 mariadb-client \
	 php81-fpm php81-phar php81-mysqli \
    php81-mbstring php81-iconv php81-session \
	 php81-tokenizer php81-pecl-redis php81-ctype

WORKDIR /var/www/html

COPY ["conf/www.conf", "/etc/php81/php-fpm.d/www.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]