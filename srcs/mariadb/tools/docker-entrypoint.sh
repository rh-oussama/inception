#!/bin/sh

echo "Starting Instalition"
mysql_install_db --user=mysql --datadir=/var/lib/mysql 2>&1 | grep "mysql.user table already exists!"

if [ $? -eq 0 ]; then
   echo "MySQL already initialized"
   exec mysqld --bind-address=0.0.0.0
fi

# Start MySQL in the background
mysqld_safe >/dev/null &

# Wait for MySQL to start
for i in $(seq 1 30); do
	echo "Waiting for MariaDB server..."
	mariadb-admin ping &>/dev/null && break
	sleep 1
done

# Secure MySQL installation
echo "Securing MySQL installation..."
mysql_secure_installation >/dev/null <<EOF
		n
		$MYSQL_ROOT_PASSWORD
		$MYSQL_ROOT_PASSWORD
		Y
		Y
		Y
		Y
EOF
echo "MySQL has been secured."

# Create database and user
echo "Creating database and user..."
mysql -u root >/dev/null <<EOF
		CREATE DATABASE IF NOT EXISTS $WP_DATABASE_NAME;
		CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_USER_PASSWORD';
		GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_USER'@'%';
		FLUSH PRIVILEGES;
EOF
echo "Database and user created."

# Shutdown and restart MySQL
mysqladmin shutdown
echo "Restarting MySQL..."
exec mysqld --bind-address=0.0.0.0