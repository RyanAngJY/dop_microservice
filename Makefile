DEP_PROTO_DIR=./proto/dep/
IMAGE_NAME=ryanang/dop_microservice:latest
.DEFAULT_GOAL := dev_start # set default target to run

# ======== Development ==========
# For development server
dev_start:
	go run main.go

# For development server (on Docker)
start:
	docker-compose down
	docker-compose up --build

shell: build 
	# to enter the shell of the image
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

# push to docker hub
push: build
	docker push $(IMAGE_NAME)
