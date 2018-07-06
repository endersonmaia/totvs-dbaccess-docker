USER = endersonmaia
NAME = $(USER)/totvs-dbaccess64
VERSION = 18-04-16-20171117

.PHONY: all build tag_latest release

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
