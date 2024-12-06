#!/bin/sh

echo "Substituting environment variables into /etc/redis.conf..."
if ! envsubst < /etc/redis.conf > /etc/redis.conf.tmp; then
	echo "Error: Failed to substitute environment variables in /etc/redis.conf"
	exit 1
fi

echo "Updating Redis configuration file..."
if ! mv /etc/redis.conf.tmp /etc/redis.conf; then
	echo "Error: Failed to update /etc/redis.conf"
	exit 1
fi

echo "Starting Redis server..."
exec redis-server /etc/redis.conf
