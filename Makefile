.PHONY: tidy
tidy:
	go mod tidy

.PHONY: go-build
go-build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o custom_scheduler .

.PHONY: docker-build
docker-build:
	# docker buildx create --use
	docker buildx build --platform linux/amd64,linux/arm64 -t registry.k8s.io/custom-plugin:latest .
