FROM golang:1.13-alpine3.12 as builder

ENV HYDROXIDE_VERSION=v0.2.17

RUN apk add --no-cache git

RUN git clone https://github.com/emersion/hydroxide.git \
    && cd hydroxide \
    && git checkout $HYDROXIDE_VERSION \
    && go build ./cmd/hydroxide

FROM lsiobase/alpine:3.12

RUN mkdir -p /config/hydroxide

COPY --from=builder /go/hydroxide/hydroxide /usr/local/bin

ENV HYDROXIDE_CMD="serve"
ENV HYDROXIDE_FLAGS="-smtp-host 0.0.0.0 -imap-host 0.0.0.0 -carddav-host 0.0.0.0"

VOLUME /config/hydroxide

EXPOSE 1025 1143 8080

COPY root/ /
