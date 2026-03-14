REPOS := gymigos-api gymigos-web gymigos-contracts gymigos-cli gymigos-infra

.PHONY: up down logs ps restart generate sync

# Switch all repos to main, pull latest, then build and start the stack
up: sync
	docker compose up --build -d

# Pull latest main in every repo
sync:
	@for repo in $(REPOS); do \
		echo "→ $$repo: switching to main and pulling..."; \
		git -C ../$$repo checkout main && git -C ../$$repo pull origin main; \
	done

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
