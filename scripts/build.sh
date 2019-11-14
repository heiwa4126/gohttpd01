#!/bin/sh
EXEC=gohttpd01
set -ue
go vet ./...
go fmt ./...

# GOOS=linux
# GOARCH=amd64
go build -o "$EXEC" -ldflags="-w -s" main.go

# if there's `upx`, upx compress binary
set +e
hash upx &> /dev/null
if [ $? -eq 0 ]; then
    upx "$EXEC"
else
    echo "no upx found. skip it."
fi
exit 0
