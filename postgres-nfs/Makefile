VERSION?=latest

all: build push

build:
	docker build -t merqlove/postgres:nfs.${VERSION} .

push:
	docker push merqlove/postgres:nfs.${VERSION}
