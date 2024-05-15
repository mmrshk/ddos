# Use a base image
FROM alpine:latest

# Install required packages
RUN apk --no-cache add curl

# Copy attack script into the container
COPY attack.sh /attack.sh

# Set the entry point
ENTRYPOINT ["sh", "/attack.sh"]
