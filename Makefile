.PHONY: up down logs ps restart

up:
	docker compose up --build -d

down:
	docker compose down

logs:
	docker compose logs -f

ps:
	docker compose ps

restart:
	docker compose restart

api-logs:
	docker compose logs -f api

db-logs:
	docker compose logs -f db
