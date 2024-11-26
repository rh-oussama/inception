#!/bin/sh


# check if the php-fpm service is up
for i in $(seq 1 100); do
	echo "waiting for php-fpm"
	nc -zv wordpress 9000 &>/dev/null && { 
		break; 
	}
	sleep 10
done

echo "Starting nginx..."
exec nginx -g "daemon off;"