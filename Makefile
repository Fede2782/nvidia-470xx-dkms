.PHONY: download build-% test test-%

CONTAINER_ENGINE := $(shell command -v podman >/dev/null 2>&1 && echo podman || echo docker)

download:
	./download

build-%: download
	$(CONTAINER_ENGINE) build -f Dockerfile_$*_kernel -t nvidia-470xx-$* .

test-%: build-%
	$(CONTAINER_ENGINE) run --network none --rm nvidia-470xx-$*

test: test-legacy test-ubuntu-lts test-ubuntu-lts-hwe test-ubuntu-lts-hwe-edge
