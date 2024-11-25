#!/bin/sh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Helper function for timestamped messages
log_message() {
   echo -e "${2}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

# Initialize the MySQL database
log_message "Checking MySQL installation status..." "$BLUE"
mysql_install_db --user=mysql --datadir=/var/lib/mysql 2>&1 | grep -q "mysql.user table already exists!"
status=$?

if [ $status -eq 0 ]; then
   log_message "MySQL already initialized" "$GREEN"
else
   log_message "Fresh MySQL installation detected" "$YELLOW"
fi

# Start MySQL daemon in the background
log_message "Starting MySQL daemon in background..." "$BLUE"
mysqld_safe >/dev/null&

# Wait for MySQL to be ready
log_message "Waiting for mysqld to be ready..." "$YELLOW"
while true; do
	if mariadb-admin ping -h localhost &>/dev/null; then
		log_message "mysqld is up and running!" "$GREEN"
		break
	fi
		log_message "mysqld init process in progress..." "$YELLOW"
		sleep 1
done


if [ $status -ne 0 ]; then
	log_message "Configuring MySQL security and database..." "$BLUE"
	echo -e "n\n$MYSQL_ROOT_PASSWORD\n$MYSQL_ROOT_PASSWORD\nY\nY\nY\nY" | mysql_secure_installation >/dev/null
	if [ $? -eq 0 ]; then
		log_message "MySQL security configuration completed" "$GREEN"
	else
		log_message "Failed to configure MySQL security" "$RED"
		exit 1
	fi

	log_message "Creating database and user..." "$BLUE"
	echo "CREATE DATABASE IF NOT EXISTS $WP_DATABASE_NAME; GRANT ALL ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USER'@'%' IDENTIFIED BY '$WP_DATABASE_USER_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
	if [ $? -eq 0 ]; then
		log_message "Database and user created successfully" "$GREEN"
	else
		log_message "Failed to create database and user" "$RED"
		exit 1
	fi
fi

log_message "Shutting down MySQL for foreground restart..." "$BLUE"
mysqladmin shutdown

log_message "Starting MySQL in foreground..." "$GREEN"
exec mysqld_safe