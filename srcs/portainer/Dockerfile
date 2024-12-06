FROM alpine:3.18

RUN apk --no-cache add \
    curl \
    tar \
	 apache2-utils


COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]