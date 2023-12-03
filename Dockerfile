# Stage 1: Build the Go binary
FROM golang:latest AS builder

# Set the working directory in the container
WORKDIR /go/src/app

# Copy the local package files to the container's workspace
COPY . .

# Build the Go app
RUN GOARCH=amd64 CGO_ENABLED=0 GOOS=linux go build -o ./bin/api_quotes .

# Stage 2: Create a minimal image with only the Go binary
FROM alpine:latest

# Set the working directory in the container
WORKDIR /app

# Copy data from the builder stage
COPY --from=builder /go/src/app/quotes/quotes.json /app/quotes/quotes.json

# Copy only the binary from the builder stage
COPY --from=builder /go/src/app/bin/api_quotes /app/bin/api_quotes
RUN chmod +x /app/bin/api_quotes

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["/app/bin/api_quotes"]
