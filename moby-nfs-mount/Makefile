VERSION?=latest

all: build push

build:
	docker build -t cnsa/moby-nfs-mount:${VERSION} .

push:
	docker push cnsa/moby-nfs-mount:${VERSION}
