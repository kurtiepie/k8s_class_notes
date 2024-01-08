VERSION := $(shell cat VERSION)
COMMIT := $(shell git rev-parse --short HEAD)
LONG_VERSION := $(VERSION)-$(COMMIT)

build: ## Build Dockerfile
#	ifeq($(trivy config Dockerfile --severity CRITICAL,HIGH  --exit-code 193),192)
#		@echo TEST Faild	
#	else
#		@echo Rest passed
#		docker build . -t localhost:5001/headers:v$(LONG_VERSION)
#	endif

	# Gates for security scan
	#docker scan localhost:5001/headers:v$(LONG_VERSION)	
	#trivy image localhost:5001/headers:v$(LONG_VERSION) --severity CRITICAL,HIGH

push: ## Push to local registry
	docker push localhost:5001/headers:v$(LONG_VERSION)
	
deploy: ## deploy helm chart
	helm install header --set image.tag=v$(LONG_VERSION) ./headerschart/ -f ./headerschart/values.yaml || \
#	helm template headerschart/ --values headerschart/values.yaml > deployment.yaml
#	trivy config --severity UNKNOWN,LOW,MEDIUMCRITICAL,HIGH --exit-code 192 deployment.yaml && \
#		helm install header --set image.tag=v$(LONG_VERSION) ./headerschart/ -f ./headerschart/values.yaml || \
#			printf "Helm Chart Deploy Failed ... See triy scan results"	


foo:
	@echo $(bar)

help:
	  @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
