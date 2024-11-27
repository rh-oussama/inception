# Use Alpine Linux as the base image
FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add nginx

RUN mkdir -p /var/www/html && \
    chown -R nginx:nginx /var/www/html && \
    chmod 755 /var/www/html

COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]
COPY ["conf/default.conf", "/etc/nginx/http.d"]
RUN chmod +x /usr/local/bin/docker-entrypoint.sh


ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]