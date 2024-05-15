#!/bin/bash

docker stop defender attacker 2>/dev/null

docker rm defender attacker 2>/dev/null

# Build the defender image
docker build -t defender -f defender.dockerfile .

# Build the attacker image
docker build -t attacker -f attacker.dockerfile .

# Run the defender container
docker run -d --privileged --name defender -p 80:80 defender

defender_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' defender)

# Run the attacker container with the defender IP address as an environment variable
docker run -d --name attacker -e DEFENDER_IP=$defender_ip attacker

# Function to follow logs
follow_logs() {
  echo "Defender logs:"
  docker logs -f defender &
  echo "Attacker logs:"
  docker logs -f attacker &
  wait
}

# Display logs in the current terminal
follow_logs