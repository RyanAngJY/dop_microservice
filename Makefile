DEP_PROTO_DIR=./proto/dep/
IMAGE_NAME=ryanang/dop_microservice:latest
.DEFAULT_GOAL := dev_start # set default target to run

build:
	docker build -t $(IMAGE_NAME) .

push_to_docker_hub:
	make build
	docker push $(IMAGE_NAME)

# ======== Development ==========
start:
	docker-compose up --build

dev_start:
	go run main.go

shell: # to enter the shell of the image
	make build
	docker run -it $(IMAGE_NAME) /bin/sh

# ========= Proto installation and generation ===========
install_proto_common:
	./proto/install_proto_common.sh

gen:
	protoc -I=$(DEP_PROTO_DIR) --go_out=plugins=grpc:proto/dep $(DEP_PROTO_DIR)/*/*.proto

install_gen:
	make install_proto_common
	make gen
