FROM alpine:latest

# Install packages
RUN apk update && \
    apk add --no-cache mariadb mariadb-client

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /

ENTRYPOINT ["/entrypoint.sh"]