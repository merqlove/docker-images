VERSION?=latest

all: build push

build:
	docker build -t merqlove/moby-nfs-mount:${VERSION} .

push:
	docker push merqlove/moby-nfs-mount:${VERSION}
