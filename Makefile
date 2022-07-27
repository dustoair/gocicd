all: build-darwin-amd64 build-darwin-arm64 build-linux-amd64 build-linux-arm64 build-windows-amd64


build-darwin-amd64:
	mkdir -p build
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go mod tidy
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o build/biz_darwin_amd64 main.go


build-darwin-arm64:
	mkdir -p build
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go mod tidy
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -o build/biz_darwin_arm64 main.go

build-linux-amd64:
	mkdir -p build
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go mod tidy
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o build/biz_linux_amd64 main.go

build-linux-arm64:
	mkdir -p build
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go mod tidy
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o build/biz_linux_arm64 main.go

build-windows-amd64:
	mkdir -p build
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go mod tidy
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o build/biz_windows_amd64.exe main.go

build-docker-image:
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go mod tidy
	docker buildx build --platform linux/amd64,linux/arm64 -t sre/gocicd . --push

gox-linux:
	gox -osarch="linux/amd64 linux/arm64" -output="build/biz_{{.OS}}_{{.Arch}}"

gox-all:
	gox -osarch="darwin/amd64 darwin/arm64 linux/amd64 linux/arm64 windows/amd64" -output="build/biz_{{.OS}}_{{.Arch}}"

clean:
	rm -f build/biz_*