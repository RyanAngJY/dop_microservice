DEP_PROTO_DIR=./proto/dep/
IMAGE_NAME=ryanang/microservice:latest

push: # to be implemented
	echo "To be implemented"

build:
	go build main.go

start:
	go run main.go

dev_start:
	make start

enter: # to enter the shell of the image
	docker build -t $(IMAGE_NAME) .
	docker run -it $(IMAGE_NAME) /bin/sh

# ========= Proto installation and generation ===========
install_proto_common:
	./proto/install_proto_common.sh

gen: # Ryan TODO: By right, you are supposed to pull from the proto repository and compile instead of directly compiling from the source
	protoc -I=$(DEP_PROTO_DIR) --go_out=plugins=grpc:proto/dep $(DEP_PROTO_DIR)/*/*.proto

install_gen:
	make install_proto_common
	make gen