FROM alpine:3.18

# Update and install necessary packages for WordPress and php-fpm
RUN apk update && \
	 apk upgrade && \
	 apk add curl && \
	 apk add php81 php81-fpm php81-mysqli php81-json php81-session php81-phar php81-mbstring && \
	 mkdir -p /var/www/html

# Set the working directory for the WordPress installation
WORKDIR /var/www/html

# Create a dedicated web service user and set appropriate permissions
RUN adduser -S -G www-data www-data && \
	 chown -R www-data:www-data /var/www/html && \
	 chmod -R 755 /var/www/html

# Copy configuration files
COPY ["conf/www.conf", "/etc/php81/php-fpm.d/www.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

# Ensure the entrypoint script is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Define the entrypoint for the container
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]