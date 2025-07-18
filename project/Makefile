FRONT_END_BINARY=front-end
BROKER_BINARY=broker-service

up:
	@echo "Starting Docker containers..."
	docker-compose up -d
	@echo "Docker containers started!"

up_build: build_broker
	@echo "Stopping and removing docker containers"
	docker-compose down
	@echo "Building and starting docker containers..."
	docker-compose up --build --no-cache -d
	@echo "Docker containers built and started!"

down:
	@echo "Stopping docker compose..."
	docker-compose down
	@echo "Done!"

build_broker:
	@echo "Building broker binary..."
	cd ../broker-service && GOOS=linux GOARCH=amd64 go build -o ./bin/api/${BROKER_BINARY} ./cmd/api
	@echo "Done!"

build_front:
	@echo "Building front end binary..."
	cd ../front-end && GOOS=linux GOARCH=amd64 go build -o ./bin/web/${FRONT_END_BINARY} ./cmd/web
	@echo "Done!"

clean_build:
	@echo "Removing binaries..."
	@rm -f ./bin/api/${BROKER_BINARY}
	@rm -f ./bin/api/${FRONT_END_BINARY}
	@echo "Done!"

start_broker: build_broker
	@echo "Running broker"
	cd ../broker-service && export CONFIG_PATH=$(CONFIG_PATH) && ./bin/api/${BROKER_BINARY} &

stop_broker:
	@echo "Stopping broker..."
	@-pkill -SIGTERM -f "./bin/api/${BROKER_BINARY}"
	@echo "Stopped broker!"

start_front: build_front
	@echo "Running front end"
	cd ../front-end && ./bin/web/${FRONT_END_BINARY} &

stop_front:
	@echo "Stopping front end..."
	@-pkill -SIGTERM -f "./bin/web/${FRONT_END_BINARY}"
	@echo "Stopped front end!"

check_port:
	@ss -ltnp | grep :$(PORT) || echo "Port $(PORT) is free"
