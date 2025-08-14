.PHONY: setup dev lint typecheck test up down logs fmt

PY?=python3
PIP?=pip

setup:
	$(PY) -m venv .venv && . .venv/bin/activate && pip install -U pip
	. .venv/bin/activate && pip install -r requirements.txt

dev:
	. .venv/bin/activate && FLASK_APP=src/app/main.py flask run --host=$${API_HOST:-0.0.0.0} --port=$${API_PORT:-8000}

lint:
	ruff check .

fmt:
	ruff format .

typecheck:
	mypy src

test:
	pytest -q

up:
	docker compose up -d --build

down:
	docker compose down -v

logs:
	docker compose logs -f api