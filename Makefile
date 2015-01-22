BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

NAME = kibana-chen
IMAGE = lotreal/kibana-chen
PORT = 5601

define docker_run_flags
--link es:es
endef


.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: pull
pull:
	docker pull $(IMAGE)

.PHONY: push
push:
	docker push $(IMAGE)

.PHONY: test
test:
	docker run --rm -it --publish ${PORT}:3000 $(docker_run_flags) $(IMAGE) morbo script/kbnauth

.PHONY: clean
clean:
	-docker rm -f $(NAME)

.PHONY: run
run:
	docker run --detach --name $(NAME) --publish $(PORT):80 $(docker_run_flags) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
