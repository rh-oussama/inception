FROM alpine:latest

RUN apk update && \
	 apk upgrade && \
	 apk add nginx 

# COPY ["conf/default.conf", "/etc/nginx/http.d/default.conf"]
COPY ["tools/docker-entrypoint.sh", "/usr/local/bin/"]

# Ensure the entrypoint script is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh


ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]