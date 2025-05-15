.PHONY: refactor test coverage clean install run lint

UV := ~/.local/bin/uv
VENV := .venv

refactor:
	chmod +x scripts/refactor_to_src.sh
	./scripts/refactor_to_src.sh

install:
	@echo "📦 Installing dependencies using uv..."
	$(UV) pip install -r requirements.txt

test:
	@echo "🧪 Running tests with pytest..."
	PYTHONPATH=./src $(UV) pip run pytest tests

coverage:
	@echo "📊 Running tests with coverage..."
	PYTHONPATH=./src $(UV) pip run pytest --cov=agency --cov-report=term --cov-report=html tests

lint:
	@echo "🧹 Linting with ruff..."
	PYTHONPATH=./src $(UV) pip run ruff check src tests

run:
	@echo "🚀 Running main application..."
	PYTHONPATH=./src $(UV) pip run python main.py

clean:
	@echo "🧼 Cleaning up..."
	find . -type d -name "__pycache__" -exec rm -r {} +
	rm -rf .pytest_cache $(VENV) htmlcov
