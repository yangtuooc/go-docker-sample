ARG BRANCH=main

FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache make
RUN make echo branch=${BRANCH}
RUN go build -o /app/bin .

FROM alpine:3.14
WORKDIR /app
COPY --from=builder /app/bin .
ENTRYPOINT ["/app/bin"]
