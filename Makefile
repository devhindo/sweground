.PHONY: pg pg-stop

pg:
	@echo "Starting PostgreSQL container..."
	@docker build -t sweground-postgres -f docker/postgres . > /dev/null 2>&1 || true
	@docker stop sweground-postgres-container > /dev/null 2>&1 || true
	@docker rm -f sweground-postgres-container > /dev/null 2>&1 || true
	@docker run -d --name sweground-postgres-container -p 5433:5432 sweground-postgres > /dev/null
	@echo "Waiting for PostgreSQL to be ready..."
	@sleep 3
	@echo "Connecting to PostgreSQL shell..."
	@docker exec -it sweground-postgres-container psql -U postgres -d playground

pg-stop:
	@echo "Stopping PostgreSQL container..."
	@docker stop sweground-postgres-container > /dev/null 2>&1 || true
	@docker rm -f sweground-postgres-container > /dev/null 2>&1 || true
	@echo "PostgreSQL container stopped."
