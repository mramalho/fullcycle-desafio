FROM golang:1.20 AS builder

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]