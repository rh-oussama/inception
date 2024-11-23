#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

wait_for_db() {
    echo -e "${CYAN}Waiting for database to be ready...${NC}"
    for i in $(seq 1 30); do
        if mariadb-admin ping -h localhost &>/dev/null; then
            echo -e "${GREEN}Database is ready!${NC}"
            return 0
        fi
        echo -e "${YELLOW}Database init process in progress... (attempt $i of 30)${NC}"
        sleep 1
    done
    echo -e "${RED}Database init process failed after 30 attempts.${NC}"
    return 1
}

if [ -z "${WP_DATABASE}" ] || [ -z "${WP_USER}" ] || [ -z "${WP_PASSWORD}" ]; then
    echo -e "${RED}Error: Required environment variables are not set.${NC}"
    echo -e "${RED}WP_DATABASE: ${WP_DATABASE}${NC}"
    echo -e "${RED}WP_USER: ${WP_USER}${NC}"
    echo -e "${RED}WP_PASSWORD: ${WP_PASSWORD}${NC}"
    exit 1
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo -e "${CYAN}Initializing database...${NC}"
	 echo -e "-----------------------------"
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
	 echo -e "-----------------------------"
    /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' >dev/null &
	 echo -e "-----------------------------"
    pid="$!"
    wait_for_db || exit 1
    echo -e "${CYAN}Creating WordPress database and user...${NC}"
    mariadb -u root <<-EOSQL
CREATE DATABASE IF NOT EXISTS \`${WP_DATABASE}\`;
CREATE USER '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WP_DATABASE}\`.* TO '${WP_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL
    echo -e "${GREEN}Database and user created successfully!${NC}"
else
    echo -e "${CYAN}Database already initialized. Skipping initialization.${NC}"
fi

# Finish the script
echo -e "${GREEN}Script completed successfully.${NC}"
