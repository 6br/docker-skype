all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build the skype image"
	@echo "   1. make install          - install launch wrappers"
	@echo "   2. make skype 				   - launch skype"
	@echo "   2. make bash             - bash login"
	@echo ""

build:
	@docker build --tag=${USER}/skype .

install uninstall: build
	@docker run -it --rm \
		--volume=/usr/local/bin:/target \
		${USER}/skype:latest $@

skype bash:
	@docker run -it --rm \
		--env="USER_UID=$(shell id -u)" \
		--env="USER_GID=$(shell id -g)" \
		--env="DISPLAY=${DISPLAY}" \
		--volume=$(HOME)/.Skype:/home/skype/.Skype \
		--volume=$(HOME)/Downloads:/home/skype/Downloads \
		--volume=/tmp/.X11-unix:/tmp/.X11-unix \
		--volume=/run/user/$(shell id -u)/pulse:/run/pulse \
		${USER}/skype:latest $@
