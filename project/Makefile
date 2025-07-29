FRONT_END_BINARY=front-end
BROKER_BINARY=broker-service
AUTH_BINARY=auth-service

up:
	@echo "Starting Docker containers..."
	docker compose down
	docker compose up -d
	@echo "Docker containers started!"

up_build: down build_broker build_auth build_front
	@echo "Stopping and removing docker containers"
	docker compose down
	@echo "Building and starting docker containers..."
	@docker compose build --no-cache
	@docker compose up -d
	@echo "Docker containers built and started!"

down: clean_build
	@echo "Stopping docker compose..."
	docker compose down
	docker image prune -f
	@echo "Done!"

############################################################################################

build_broker:
	@echo "Building ${BROKER_BINARY} binary..."
	cd ../${BROKER_BINARY} && GOOS=linux GOARCH=amd64 go build -o ./bin/app/${BROKER_BINARY} ./cmd/app
	@echo "Done!"

build_auth:
	@echo "Building ${AUTH_BINARY} binary..."
	cd ../${AUTH_BINARY} && GOOS=linux GOARCH=amd64 go build -o ./bin/app/${AUTH_BINARY} ./cmd/app
	@echo "Done!"

build_front:
	@echo "Building ${FRONT_END_BINARY} binary..."
	cd ../${FRONT_END_BINARY} && GOOS=linux GOARCH=amd64 go build -o ./bin/web/${FRONT_END_BINARY} ./cmd/web
	@echo "Done!"

############################################################################################

clean_build:
	@echo "Removing binaries..."
	@rm -f ./bin/app/${BROKER_BINARY}
	@rm -f ./bin/app/${AUTH_BINARY}
	@rm -f ./bin/web/${FRONT_END_BINARY}
	@echo "Done!"

############################################################################################

start_broker: build_broker
	@echo "Running ${BROKER_BINARY}"
	cd ../${BROKER_BINARY} && export CONFIG_PATH=$(CONFIG_PATH) && ./bin/app/${BROKER_BINARY} &

stop_broker:
	@echo "Stopping ${BROKER_BINARY}..."
	@-pkill -SIGTERM -f "./bin/app/${BROKER_BINARY}"
	@echo "Stopped ${BROKER_BINARY}!"

############################################################################################

start_auth: build_auth
	@echo "Running ${AUTH_BINARY}"
	cd ../${AUTH_BINARY} && export CONFIG_PATH=$(CONFIG_PATH) && ./bin/app/${AUTH_BINARY} &

stop_auth:
	@echo "Stopping ${AUTH_BINARY}..."
	@-pkill -SIGTERM -f "./bin/app/${AUTH_BINARY}"
	@echo "Stopped ${AUTH_BINARY}!"

############################################################################################

start_front: build_front
	@echo "Running ${FRONT_END_BINARY}"
	cd ../${FRONT_END_BINARY} && ./bin/web/${FRONT_END_BINARY} &

stop_front:
	@echo "Stopping ${FRONT_END_BINARY}..."
	@-pkill -SIGTERM -f "./bin/web/${FRONT_END_BINARY}"
	@echo "Stopped ${FRONT_END_BINARY}!"

############################################################################################

check_port:
	@ss -ltnp | grep :$(PORT) || echo "Port $(PORT) is free"
