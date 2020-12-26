DEP_PROTO_DIR=./proto/dep/proto

gen: # Ryan TODO: By right, you are supposed to pull from the proto repository and compile instead of directly compiling from the source
	protoc -I=$(DEP_PROTO_DIR) --go_out=plugins=grpc:proto/dep/go $(DEP_PROTO_DIR)/*/*.proto

push: # to be implemented
	echo "To be implemented"

build:
	go build main.go

start:
	go run main.go

dev_start:
	make start