# Use an official Go runtime as a parent image
FROM golang:latest

# Set the working directory in the container
WORKDIR /go/src/app

# Copy the local package files to the container's workspace
COPY . .

# Build the Go app
RUN go build -o ./bin/api_quotes .
RUN chmod +x ./bin/api_quotes

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./bin/api_quotes"]
