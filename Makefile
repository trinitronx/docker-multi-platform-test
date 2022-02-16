.DEFAULT_GOAL := xplatform

xplatform: amd64 arm64 ppc64le riscv64 ## Build cross-platform Docker images

amd64 arm64 ppc64le riscv64: Dockerfile
	docker build --progress plain --platform linux/$@ --tag trinitronx/multi-platform-demo:$@ .
