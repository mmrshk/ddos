FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y hping3

# Set the working directory
WORKDIR /app

COPY attack.sh /app/attack.sh
RUN chmod +x /app/attack.sh

CMD ["bash", "-c", "./attack.sh && tail -f /dev/null"]
