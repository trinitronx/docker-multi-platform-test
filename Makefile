.DEFAULT_GOAL := multi ## no-help

multi: xplatform ## Build cross-platform as multiple single-platform Docker images
.PHONY: xplatform
xplatform: amd64 arm64 riscv64 ppc64le s390x 386 arm/v7 arm/v6 arm64/v8 mips64le ## no-help

.PHONY: help list
# Auto-documented Makefile
# Source: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Shows this generated help info for Makefile targets
	@grep -E '^[a-zA-Z_-\/]+:.*?(## )?.*$$' $(MAKEFILE_LIST) | grep -v 'no-help' | sort | awk '{ if ( $$0 ~ /^[a-zA-Z_-]+:.*?## ?.*$$/ ) { split($$0,resultArr,/:.*## /) ; printf "\033[36m%-30s\033[0m %s\n", resultArr[1], resultArr[2] } else if ( $$0 ~ /^[a-zA-Z_-]+:.*$$/ ) { split($$0,resultArr,/:.*?/);  printf "\033[36m%-30s\033[0m\n", resultArr[1] } } '

list: ## Just list all Makefile targets without help
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs


.PHONY: amd64 arm64 riscv64 ppc64le s390x 386 mips64le arm/v7 arm/v6 arm64/v8
amd64 arm64 riscv64 ppc64le s390x 386 arm/v7 arm/v6 arm64/v8: Dockerfile ## no-help
	docker build --progress plain --platform linux/$@ --tag trinitronx/multi-platform-demo:$(subst /,_,$@)  .

buildx: Dockerfile ## Build multi-platform with buildx multiple platform manifest list
	docker buildx build --builder docker-multiplatform --progress plain --platform linux/amd64,linux/arm64,ppc64le,riscv64 --tag trinitronx/multi-platform-demo:multi-platform .

bake: Dockerfile ## Build multi-platform with buildx bake + docker-compose.buildx.yml
	docker buildx bake --builder docker-multiplatform --file docker-compose.buildx.yml

# Alpine Linux does not yet support mips64* platforms
mips64le: ## Build mips64le debian:testing-slim image
	docker build --progress plain --platform linux/$@ --build-arg RELEASE_IMAGE=debian:testing-slim --tag trinitronx/multi-platform-demo:$(subst /,_,$@)  .

mips64: ## Build mips64 busybox image
	docker build --progress plain --platform linux/$@ --build-arg RELEASE_IMAGE=busybox --tag trinitronx/multi-platform-demo:$(subst /,_,$@)  .

check: xplatform ## Check the resulting docker images ENTRYPOINT command: uname -m
	for p in amd64 arm64 arm64_v8 arm_v6 arm_v7 ppc64le riscv64 386 s390x mips64le ; do  docker run -ti trinitronx/multi-platform-demo:$${p} ; done
