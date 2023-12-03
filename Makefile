init:
	docker run --rm -v $(shell pwd):/app -w /app golang:latest go mod init quotes

get:
	docker run --rm -v $(shell pwd):/app -w /app golang:latest go get -v ./...

build:
	docker-compose build

run:
	docker-compose up --build -d

stop:
	docker-compose down
