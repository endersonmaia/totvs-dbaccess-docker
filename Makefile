USER = endersonmaia
NAME = $(USER)/totvs-dbaccess64
VERSION = 16-11-10-20160402

.PHONY: all build tag_latest release

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
