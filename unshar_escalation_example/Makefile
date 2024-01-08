VERSION := $(shell cat VERSION)
COMMIT := $(shell git rev-parse --short HEAD)
LONG_VERSION := $(VERSION)-$(COMMIT)

build: ## Build Dockerfile
	docker build . -t localhost:5001/headers:v$(LONG_VERSION)

push: ## Push to local registry
	docker push localhost:5001/headers:v$(LONG_VERSION)
	
deploy: ## deploy helm chart
	helm install header --set image.tag=v$(LONG_VERSION) ./headerschart/ -f ./headerschart/values.yaml

help:
	  @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
