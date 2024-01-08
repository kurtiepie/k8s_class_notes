FROM golang:1.16-alpine as builder

WORKDIR /app


COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o ./headers

FROM alpine:3.13

COPY --from=builder /app/headers /bin/headers

CMD [ "/bin/headers"]
