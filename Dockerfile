FROM golang:1.15-alpine AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
RUN CGO_ENABLED=0 go get -v github.com/rubenv/sql-migrate/...

FROM alpine:3.10

WORKDIR /workspace
COPY --from=builder /go/bin/sql-migrate /usr/local/bin/sql-migrate

RUN set -ex && \
  chmod +x /usr/local/bin/* && \
  rm -rf /var/cache/apk/*
