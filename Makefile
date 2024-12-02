DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
VOLUME_DIR = /home/orhaddao/data

all: build up

build:
	sudo mkdir -p /home/orhaddao/data/wordpress
	sudo mkdir -p /home/orhaddao/data/mariadb
	@echo "Building Docker images..."
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) build

up: build
	@echo "Starting Docker containers..."
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@echo "Stopping and removing containers..."
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) down

clean:
	@echo "Cleaning up Docker containers"
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) down

fclean: clean
	@echo "Cleaning up Docker volumes"
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) down --rmi all -v
	@echo "Deleting target directory $(TARGET_DIR)..."
	@sudo rm -rf $(VOLUME_DIR)

# @echo "Cleaning up Docker images "
# @sudo docker image rm -f $(sudo docker images -q)
	

logs:
	@echo "Displaying Docker logs..."
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) logs

stats:
	@echo "Displaying Docker state..."
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) stats


restart: down up
	@echo "Restarting Docker containers..."

ps:
	@echo "Listing running Docker containers..."
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) ps


attach:
	@echo "Select a service to access its container terminal:"
	@echo "  make nginx      - Attach to Nginx container"
	@echo "  make mariadb    - Attach to MariaDB container"
	@echo "  make wordpress  - Attach to WordPress container"

nginx:
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) exec nginx sh

mariadb:
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) exec mariadb sh

wordpress:
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) exec wordpress sh

redis:
	@sudo docker compose -f $(DOCKER_COMPOSE_FILE) exec redis sh


help:
	@echo "Makefile targets:"
	@echo "  all       - Build and start containers"
	@echo "  build     - Build Docker images"
	@echo "  up        - Start containers in detached mode"
	@echo "  down      - Stop and remove containers"
	@echo "  fclean    - Clean up containers, volumes, networks, and delete $(TARGET_DIR)"
	@echo "  logs      - View Docker logs"
	@echo "  restart   - Restart containers"
	@echo "  ps        - List running containers"
	@echo "  help      - Display this help message"

.PHONY: all build up down fclean logs restart ps help nginx mariadb wordpress
