FROM alpine:3.18


RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    curl tar apache2-utils

COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]