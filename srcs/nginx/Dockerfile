FROM alpine:3.18

RUN apk update && \
    apk upgrade &&\
    apk add --no-cache \
    nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl

RUN openssl req -x509 -nodes \
	 -days 365 -newkey rsa:4096 \
	 -keyout /etc/nginx/ssl/inception.key \
	 -out /etc/nginx/ssl/inception.crt \
	 -subj "/C=MA/ST=Marrakech-safi/L=Ben-Guerir/O=1337/OU=42/CN=inception"

RUN chmod 600 /etc/nginx/ssl/inception.key && \
	 chmod 644 /etc/nginx/ssl/inception.crt && \
	 chown nginx:nginx /etc/nginx/ssl/inception.key && \
	 chown nginx:nginx /etc/nginx/ssl/inception.crt

RUN mkdir -p /var/www/html && \
    chown -R nginx:nginx /var/www/html && \
    chmod 755 /var/www/html

COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]
COPY ["conf/default.conf", "/etc/nginx/http.d"]
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]