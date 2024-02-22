FROM golang:1.22.0-alpine
# Install everything to our hosted dir
ENV GOMODCACHE=/tmp/goproxy-gomodcache

# go proxy
RUN go install github.com/goproxy/goproxy/cmd/goproxy@latest

# vscode stuff
# gopls is the official Go language server developed by the Go team
RUN go install golang.org/x/tools/gopls@latest
# This is the default lint tool
RUN go install honnef.co/go/tools/cmd/staticcheck@latest
# This extension uses Delve for its debug/test functionalities
RUN go install github.com/go-delve/delve/cmd/dlv@latest
# This tool provides support for the Go: Generate Unit Tests set of commands.
RUN go install github.com/cweill/gotests/gotests@latest
# This tool provides support for the Go: Add Tags to Struct Fields and Go: Remove Tags From Struct Fields commands
RUN go install github.com/fatih/gomodifytags@latest
# This tool provides support for the Go: Generate Interface Stubs command.
RUN go install github.com/josharian/impl@latest
# RUN go install github.com/haya14busa/goplay@latest -- only for running on goplayground

# proto
# RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install -x google.golang.org/protobuf/...@latest

# mqtt
RUN go install github.com/eclipse/paho.mqtt.golang/...@latest

# 
# RUN go get package google.golang.org/protobuf@latest

COPY main.go /go/src/clienttest/main.go
WORKDIR /go/src/clienttest
RUN go mod init clienttest
RUN go get -u 
RUN go mod tidy

# vscode
ENTRYPOINT  goproxy server --address :8080 --connect-timeout 1ms --fetch-timeout 1ms
