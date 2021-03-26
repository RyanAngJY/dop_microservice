DEP_PROTO_DIR=./proto/dep/
IMAGE_NAME=ryanang/dop_microservice:latest
.DEFAULT_GOAL := dev_start # set default target to run

# ======== Development ==========
dev_start:
	go run main.go

start:
	docker-compose up --build

shell: # to enter the shell of the image
	make build
	docker run -it $(IMAGE_NAME) /bin/sh

# ========= Proto installation and generation ===========
# Install proto and generate go files
install_and_gen:
	make install_proto_common
	make gen

# Install proto files
install_proto_common:
	./proto/install_proto_common.sh

# Generate go files from proto files
gen:
	protoc -I=$(DEP_PROTO_DIR) --go_out=plugins=grpc:proto/dep $(DEP_PROTO_DIR)/*/*.proto

# ========= Building Docker Image ===========
build:
	docker build -t $(IMAGE_NAME) .

push_to_docker_hub:
	make build
	docker push $(IMAGE_NAME)
