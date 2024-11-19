FROM alpine:3.20.3
RUN mkdir /app
WORKDIR /app
RUN touch a.sh;  echo "a" > a.sh
RUN chmod +x a.sh
RUN apk update
CMD [ "tail", "-f", "/dev/null" ]