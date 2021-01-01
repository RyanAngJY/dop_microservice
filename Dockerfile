FROM golang:1.14-alpine3.11

# Set the Current Working Directory inside the container
WORKDIR $GOPATH/src/github.com/dop_microservice

COPY ./go.* ./
RUN go mod download

# Copy everything from the current directory to the PWD (Present Working Directory) inside the container
COPY . .

# Install the package as binary
RUN go install -v ./...

# This container exposes port 50051 to the outside world
EXPOSE 50051

# Run the go executable
CMD ["microservice"]
