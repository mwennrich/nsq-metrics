APP_NAME := nsq-metrics
DOCKER_REGISTRY ?= docker.io/mwennrich
DOCKER_TAG := $(or ${GIT_TAG_NAME}, latest)

.PHONY: tidy build run docker-build

tidy:
	go mod tidy

build:
	go build ./...

run:
	go run ./agent.go

docker-build:
	@docker build -t $(DOCKER_REGISTRY)/$(APP_NAME):$(DOCKER_TAG) .

docker-push: docker-build
	@docker push $(DOCKER_REGISTRY)/$(APP_NAME):$(DOCKER_TAG)
