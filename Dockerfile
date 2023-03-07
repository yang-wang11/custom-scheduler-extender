FROM golang:1.19 AS builder

# RUN apk update && apk upgrade && \
#     apk add --no-cache bash git openssh

WORKDIR /workspace

COPY go.mod go.mod
COPY go.sum go.sum
COPY *.go ./
COPY Makefile Makefile

RUN make tidy
RUN make go-build

FROM scratch

WORKDIR /
COPY --from=builder /workspace/custom_scheduler /

ENTRYPOINT ["/custom_scheduler"]