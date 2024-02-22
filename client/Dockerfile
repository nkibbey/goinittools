FROM golang:1.22.0-alpine

ENV GOPROXY=http://localhost:8080
COPY main.go /go/src/clienttest/main.go
WORKDIR /go/src/clienttest
RUN go mod init clienttest
# RUN go get -u 
# RUN go mod tidy
# RUN go build .
