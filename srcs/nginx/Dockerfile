FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add nginx

CMD ["nginx", "-g", "daemon off;"]