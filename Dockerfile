FROM golang:alpine AS builder

RUN apk add make binutils
COPY / /work
WORKDIR /work

RUN go build

FROM scratch
COPY --from=builder /work/nsq-metrics /nsq-metrics
USER 999
ENTRYPOINT ["/nsq-metrics"]

EXPOSE 9117
