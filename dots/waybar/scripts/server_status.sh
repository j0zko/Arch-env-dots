#!/bin/bash

# Define the host and port of your server
HOST="localhost"
PORT="2222"

# Check if the port is open
# The timeout (-w 1) is crucial to prevent the script from hanging
if nc -z -w 1 "$HOST" "$PORT" &>/dev/null; then
  echo "  Server UP"
else
  echo "  Server DOWN"
fi
