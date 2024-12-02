#!/bin/sh

if [ ! -f "/bin/wp" ]; then
	echo "WP-CLI not found. Downloading and installing WP-CLI..."
   curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &>/dev/null
	chmod +x wp-cli.phar
	mv wp-cli.phar /bin/wp
	echo "WP-CLI installed successfully!"
else
	echo "WP-CLI is already installed."
fi

if [ ! -f "index.php" ]; then
	echo "WordPress not found. Installing the latest version..." 
	curl -O https://wordpress.org/latest.zip &>/dev/null
	unzip latest.zip
	mv wordpress/* .
	rm -rf wordpress latest.zip
	echo "WordPress installed successfully!"
else
	echo "WordPress is already installed."
fi


for i in $(seq 1 30); do
	if mariadb -h $DB_HOST -u "$WP_DATABASE_USER" -p"$WP_DATABASE_USER_PASSWORD" --connect_timeout=1 -e "SELECT 1;" &>/dev/null; then
		break
	fi
	echo "Waiting for MariaDB database to be up."
	sleep 1
done

if ! mariadb -h $DB_HOST -u "$WP_DATABASE_USER" -p"$WP_DATABASE_USER_PASSWORD" --connect_timeout=1 -e "SELECT 1;" &>/dev/null; then
	echo "Error: MariaDB is not responding. Unable to establish connection."
	exit 1
fi

wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USER --dbpass=$WP_DATABASE_USER_PASSWORD --dbhost=mariadb

wp core install --url=$DOMAIN --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

wp user create "$WP_REGULAR_USER" "$WP_REGULAR_EMAIL" --role=subscriber --user_pass=$WP_REGULAR_PASSWORD

wp theme activate twentytwentyfour


bonus() {
  chown -R nobody:nobody wp-content
  wp config set FS_METHOD direct --type=constant
  wp config set WP_REDIS_HOST 'redis' --type=constant
  wp config set WP_REDIS_PORT 6379 --type=constant
  wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --type=constant
  wp config set WP_REDIS_SCHEME 'tcp' --type=constant
  wp config set WP_REDIS_USE_FS_CACHE true --type=constant
  wp plugin install redis-cache --activate
  wp redis enable
}

bonus
exec php-fpm81 -F



