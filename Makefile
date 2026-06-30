PATH=srcs/docker-compose.yml

all: up

up:
	docker compose -f up $(PATH) -d --build

down:
	docker compose -f down $(PATH)

restart: down up

clean:
	docker compose down -f $(PATH) -v

fclean:
	docker system prune -af

.PHONY: all up down restart clean fclean
