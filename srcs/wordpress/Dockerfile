FROM alpine:3.18

# Install required packages (including PHP and PHP-FPM)
RUN apk update && \
    apk upgrade && \
    apk add php81 php81-fpm php81-mysqli php81-json php81-session

# Set up proper permissions and user "www-data"
RUN addgroup -S www-data && \
    adduser -S -G www-data www-data && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html


CMD ["sh", "-c", "while :; do sleep 1; done"]