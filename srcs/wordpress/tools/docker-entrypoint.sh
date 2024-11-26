#!/bin/sh

# Download the latest WordPress release
curl -O https://wordpress.org/latest.zip

# Download and install WP-CLI for command-line WordPress management
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /bin/wp

# Extract WordPress files and clean up compressed archive
unzip latest.zip
mv wordpress/* . 
rm -rf wordpress latest.zip


# check if the mariadb service is up
for i in $(seq 1 30000000); do
	echo "waiting for mariadb"
	nc -zv mariadb 3306 &>/dev/null && { 
		break; 
	}
	sleep 5
done

nc -zv mariadb 3306 &>/dev/null || { exit 1; }



# Create WordPress configuration file with database connection details
wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USER --dbpass=$WP_DATABASE_USER_PASSWORD --dbhost=mariadb

# Install WordPress core with predefined site and admin details
wp core install --url=$DOMAIN --title="$WP_TITLE" --admin_user=adminuser --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

# Create a standard subscriber user account
wp user create "$WP_REGULAR_USER" "$WP_REGULAR_EMAIL" --role=subscriber --user_pass=$WP_REGULAR_PASSWORD

exec php-fpm81 -F



