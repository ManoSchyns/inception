COMPOSE_FILE=srcs/docker-compose.yml

all: up

# Build containers
up:
	docker compose -f $(COMPOSE_FILE) up -d --build

# Stop containers
down:
	docker compose -f $(COMPOSE_FILE) down

# Stop and restart containers
restart: down up

# Show all logs
logs:
	docker compose -f $(COMPOSE_FILE) logs

# Show running containers
info:
	docker ps

# Show only the wordpress logs
wp-logs:
	docker logs wordpress

# Show only the mariadb logs
mariadb-logs:
	docker logs mariadb

# Show only the nginx logs
nginx-logs:
	docker logs nginx

# Remove containers and volumes
clean:
	docker compose -f $(COMPOSE_FILE) down -v

# Remove all images, containers and docker volumes
fclean: clean
	docker system prune -af

.PHONY: all up down restart clean fclean logs wp-logs mariadb-logs nginx-logs info
