FROM alpine:3.18

RUN apk update && \
	 apk upgrade && \
	 apk add --no-cache \
	 vsftpd shadow

COPY ["conf/vsftpd.conf", "/etc/vsftpd/vsftpd.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
