FROM alpine:3.18

# Update and install necessary packages for WordPress and php-fpm
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

# Set the working directory for the WordPress installation
WORKDIR /var/www/html


# Copy configuration files
# COPY ["conf/www.conf", "/etc/php81/php-fpm.d/www.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

# Ensure the entrypoint script is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Define the entrypoint for the container
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]