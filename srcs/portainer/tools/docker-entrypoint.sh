#!/bin/sh

curl -L https://github.com/portainer/portainer/releases/download/2.21.4/portainer-2.21.4-linux-amd64.tar.gz -o /portainer.tar.gz && \
tar -xvf /portainer.tar.gz -C / && \
rm /portainer.tar.gz

password=$(htpasswd -bnBC 12 "" "$PORTAINER_PASSWORD" | tr -d ':\n')
export PORTAINER_PASSWORD=$password

echo $PORTAINER_PASSWORD
exec /portainer/portainer --bind=":9000" --data="/data" --admin-password=$PORTAINER_PASSWORD
