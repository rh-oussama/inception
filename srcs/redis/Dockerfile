FROM alpine:3.18


RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    redis envsubst

COPY ["conf/redis.conf", "/etc/redis.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

