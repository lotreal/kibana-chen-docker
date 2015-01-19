BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

NAME = kibana-chen
IMAGE = lotreal/kibana-chen
PORT = 5601


.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: test
test:
	docker run --rm -it --publish ${PORT}:3000 $(IMAGE) morbo script/kbnauth

.PHONY: run
run:
	docker run --detach --name $(NAME) --publish $(PORT):80 $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
