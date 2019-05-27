FROM golang:1.11 AS builder

# Config the WORKDIR
WORKDIR /src

# Copy everything from the current directory to WORKDIR
COPY . .

RUN go get ./...
RUN go build -o backend


FROM alpine

LABEL maintainer="Alessander Viana <alessander.viana@hotmail.com>"

ENV ALLOWED_ORIGIN='http://localhost:3000'
ENV REDIS_ADDR=localhost:6379

# Config the WORKDIR
WORKDIR /backend

COPY --from=builder /src/backend /backend

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Run the app
ENTRYPOINT ./backend
