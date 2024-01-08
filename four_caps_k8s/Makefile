build: ## Build Dockerfile
	docker build . -t getcaps

docker-run: ## run test image
	docker run --rm getcaps
	docker run -it --rm getcaps /bin/sh -c 'whoami'
	
help:
	  @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
