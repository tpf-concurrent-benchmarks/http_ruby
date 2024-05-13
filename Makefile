-include .env

.EXPORT_ALL_VARIABLES:
	DATABASE_URL=${DATABASE_URL}
	SECRET_KEY_BASE=${SECRET_KEY_BASE}
	POSTGRES_USER=${POSTGRES_USER}
	POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
	POSTGRES_DB=${POSTGRES_DB}

copy_env:
	if [ ! -f .env ]; then cp .env.example .env; fi

create_directories:
	mkdir -p graphite
	mkdir -p data/postgres_data

init:
	docker swarm init || true

setup: init create_directories copy_env

build:
	docker rmi http_ruby -f || true
	docker build -t http_ruby .

remove:
	if docker stack ls | grep -q http_ruby; then \
		docker stack rm http_ruby; \
	fi

deploy: remove build
	until \
	docker stack deploy \
	-c docker-compose.yaml \
	http_ruby; \
	do sleep 1; \
	done

logs:
	docker service logs http_ruby_app -f