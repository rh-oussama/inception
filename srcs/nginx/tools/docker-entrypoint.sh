#!/bin/sh

for i in $(seq 1 100); do
	echo "waiting for php-fpm"
	nc -zv wordpress 9000 &>/dev/null && { 
		break; 
	}
	sleep 1
done

echo "Starting nginx..."
exec nginx -g "daemon off;"