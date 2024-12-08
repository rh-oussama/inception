ENV_FILE = ./srcs/.env
LOGIN = $(shell grep -E '^LOGIN=' $(ENV_FILE) | sed 's/^LOGIN=//')
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
VOLUME_DIR = /home/$(LOGIN)

RED     = \033[31m
GREEN   = \033[32m
YELLOW  = \033[33m
CYAN    = \033[36m
RESET   = \033[0m
BOLD    = \033[1m

all: check-root build up

build: check-root domain-conf
	mkdir -p /home/$(LOGIN)/data/wordpress
	mkdir -p /home/$(LOGIN)/data/mariadb
	@echo "Building Docker images..."
	@docker compose -f $(DOCKER_COMPOSE_FILE) build || true

up: check-root build
	@echo "Starting Docker containers..."
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d

down: check-root
	@echo "Stopping and removing containers..."
	@docker compose -f $(DOCKER_COMPOSE_FILE) down


clean: check-root
	@echo -e "$(CYAN)$(BOLD)Step 0:$(RESET) $(YELLOW)Stopping all running Docker containers...$(RESET)"
	@docker stop $$(docker ps -qa) 2>/dev/null || true
	@echo -e "$(CYAN)$(BOLD)Step 1:$(RESET) $(YELLOW)Removing all stopped Docker containers...$(RESET)"
	@docker rm $$(docker ps -qa) 2>/dev/null || true

fclean: clean
	@echo -e "$(CYAN)$(BOLD)Step 2:$(RESET) $(YELLOW)Removing all Docker images...$(RESET)"
	@docker rmi -f $$(docker images -qa) 2>/dev/null || true
	@echo -e "$(CYAN)$(BOLD)Step 3:$(RESET) $(YELLOW)Removing all Docker volumes...$(RESET)"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@echo -e "$(CYAN)$(BOLD)Step 4:$(RESET) $(YELLOW)Removing all Docker networks...$(RESET)"
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@echo -e "$(CYAN)$(BOLD)Step 6:$(RESET) $(YELLOW)Deleting target directory '$(VOLUME_DIR)'...$(RESET)"
	@rm -rf $(VOLUME_DIR)/data || true
	@rm -rf inception.cert
	@echo -e "$(CYAN)$(BOLD)Step 5:$(RESET) $(GREEN)Docker cleanup complete!$(RESET)"

logs: check-root
	@echo "Displaying Docker logs..."
	@docker compose -f $(DOCKER_COMPOSE_FILE) logs

stats: check-root
	@echo "Displaying Docker state..."
	@docker compose -f $(DOCKER_COMPOSE_FILE) stats

restart: check-root down up
	@echo "Restarting Docker containers..."

ps: check-root
	@echo "Listing running Docker containers..."
	@docker compose -f $(DOCKER_COMPOSE_FILE) ps


attach:
	@echo "Select a service to access its container terminal:"
	@echo " docker compose -f srcs/docker-compose.yml exec SERVICE_NAME sh"

check-root:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo -e "$(RED)Run the 'MAKE' as sudo$(RESET)"; \
		exit 1; \
	fi

domain-conf:
	@echo "🌐 Configuring local domain mapping..."
	@grep -E "${LOGIN}\.42\.fr" /etc/hosts || echo -e "\n127.0.0.1    ${LOGIN}.42.fr\n" >> /etc/hosts
	@echo "✅ Local domain mapping successfully configured."

.PHONY: all build up down fclean clean logs restart ps check-root domain-conf
