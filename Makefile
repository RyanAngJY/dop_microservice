DEP_PROTO_DIR=./proto/dep/
IMAGE_NAME=ryanang/microservice:latest

build:
	docker build -t $(IMAGE_NAME) .

push_to_docker_hub: # to be implemented
	echo "To be implemented"

start:
	docker-compose up --build

dev_start:
	go run main.go

enter: # to enter the shell of the image
	make build
	docker run -it $(IMAGE_NAME) /bin/sh

# ========= Proto installation and generation ===========
install_proto_common:
	./proto/install_proto_common.sh

gen: # Ryan TODO: By right, you are supposed to pull from the proto repository and compile instead of directly compiling from the source
	protoc -I=$(DEP_PROTO_DIR) --go_out=plugins=grpc:proto/dep $(DEP_PROTO_DIR)/*/*.proto

install_gen:
	make install_proto_common
	make gen
