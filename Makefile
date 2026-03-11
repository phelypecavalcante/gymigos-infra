.PHONY: up down logs ps restart generate

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

generate:
	cd ../gymigos-api && make generate
	cd ../gymigos-contracts && npm run generate
