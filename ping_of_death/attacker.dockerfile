# Dockerfile for Ping of Death attacker
FROM debian:latest

# Install necessary tools
RUN apt-get update && \
    apt-get install -y hping3 && \
    apt-get clean

WORKDIR /app

COPY attack.sh /app/attack.sh
RUN chmod +x /app/attack.sh

CMD ["./attack.sh"]
