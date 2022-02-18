.DEFAULT_GOAL := xplatform

xplatform: amd64 arm64 riscv64 ppc64le s390x 386 arm/v7 arm/v6 arm64/v8 mips64le mips64 ## Build cross-platform Docker images


# amd64 arm64 ppc64le riscv64: Dockerfile
.PHONY: amd64 arm64 riscv64 ppc64le s390x 386 mips64le mips64 arm/v7 arm/v6 arm64/v8
amd64 arm64 riscv64 ppc64le s390x 386 arm/v7 arm/v6 arm64/v8: Dockerfile
	docker build --progress plain --platform linux/$@ --tag trinitronx/multi-platform-demo:$(subst /,_,$@)  .

# Alpine Linux does not yet support mips64* platforms
mips64le: ## Build mips64le debian:testing-slim image
	docker build --progress plain --platform linux/$@ --build-arg RELEASE_IMAGE=debian:testing-slim --tag trinitronx/multi-platform-demo:$(subst /,_,$@)  .

mips64: ## Build mips64 busybox image
	docker build --progress plain --platform linux/$@ --build-arg RELEASE_IMAGE=busybox --tag trinitronx/multi-platform-demo:$(subst /,_,$@)  .
