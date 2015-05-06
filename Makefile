all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""  this Makefile is here just to make it easy to build this for testing purposes
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: builddocker rundocker beep

rundocker:
	@docker run --name=docker-chef-solo \
	--cidfile="cid" \
	-v /tmp:/tmp \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t joshuacox/docker-chef-solo

builddocker:
	/usr/bin/time -v docker build -t joshuacox/docker-chef-solo .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-name:
	rm  name

rm-image:
	@docker rm `cat cid`
	@rm cid

cleanfiles:
	rm name
	rm repo
	rm proxy
	rm proxyport

rm: kill rm-image

clean: cleanfiles rm

enter:
	docker exec -i -t `cat cid` /bin/bash
