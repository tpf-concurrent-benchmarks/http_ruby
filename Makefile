run_local:
	rails s

copy_env:
	if [ ! -f .env ]; then cp .env.example .env; fi

create_directories:
	mkdir -p graphite

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