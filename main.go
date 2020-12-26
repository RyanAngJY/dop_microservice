package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"

	"google.golang.org/grpc/reflection"

	"microservice/proto/dep/go/core"

	"google.golang.org/grpc"
)

type server struct{}

type blogItem struct {
	ID       int
	AuthorID int
	Content  string
	Title    string
}

func (*server) GetBlog(ctx context.Context, req *core.GetBlogRequest) (*core.GetBlogResponse, error) {
	fmt.Println("Get Blog request")
	return &core.GetBlogResponse{Blog: &core.Blog{
		Id:       1,
		AuthorId: 1,
		Title:    "My Title",
		Content:  "My Content",
	}}, nil
}

func main() {
	log.SetFlags(log.LstdFlags | log.Lshortfile) // if we crash the go code, we get the file name and line number

	lis, err := net.Listen("tcp", "0.0.0.0:50051")
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	opts := []grpc.ServerOption{}
	s := grpc.NewServer(opts...)
	core.RegisterBlogServiceServer(s, &server{})
	// Register reflection service on gRPC server.
	reflection.Register(s)

	go func() {
		fmt.Println("Starting Server...")
		if err := s.Serve(lis); err != nil {
			log.Fatalf("Failed to serve: %v", err)
		}
	}()

	// Wait for Control C to exit
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, os.Interrupt)

	// Block until a signal is received
	<-ch

	// Second step : closing the listener
	fmt.Println("Closing the listener")
	if err := lis.Close(); err != nil {
		log.Fatalf("Error on closing the listener : %v", err)
	}
	// Finally, we stop the server
	fmt.Println("Stopping the server")
	s.Stop()
	fmt.Println("End of Program")
}
