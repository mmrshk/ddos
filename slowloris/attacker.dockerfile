# Dockerfile for Slowloris attacker
FROM python:3.8-slim

RUN pip install slowloris

WORKDIR /app

COPY attack.sh /app/attack.sh
RUN chmod +x /app/attack.sh

CMD ["./attack.sh"]
