VERSION = v0.1
IMAGE_NAME = foreman

all: build
build:
	docker build --pull -t ${IMAGE_NAME}:${VERSION} -t ${IMAGE_NAME} .
	docker run -tdi -p 443:443 -p 8443:8443 --name ${IMAGE_NAME} -p 8140:8140 --hostname="localhost.localdomain" ${IMAGE_NAME}
	docker exec ${IMAGE_NAME} foreman-installer
	@if docker images ${IMAGE_NAME}:${VERSION}; then touch build; fi

clean:
	rm -f build