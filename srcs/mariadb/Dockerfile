# Use Alpine 3.18 as base image for a lightweight container
FROM alpine:3.18

# Install required packages
RUN apk update && \
	 apk add mariadb && \
	 apk add mariadb-client

# Configure MySQL directories and permissions
RUN mkdir -p /var/run/mysqld && \
    mkdir -p /var/lib/mysql && \
	 mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
	 chown -R mysql:mysql /var/log/mysql && \
    chmod 777 /var/run/mysqld

# Copy custom entrypoint script
COPY ["conf/my.cnf", "/etc"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

# Give execute permission to docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
