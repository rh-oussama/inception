FROM alpine:3.18

RUN apk update && \
	 apk add mariadb && \
	 apk add mariadb-client

RUN mkdir -p /var/run/mysqld && \
    mkdir -p /var/lib/mysql && \
	 mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
	 chown -R mysql:mysql /var/log/mysql && \
    chmod 777 /var/run/mysqld

COPY ["conf/my.cnf", "/etc"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
