#!/bin/sh -e

# Initialise environment
echo "[$(date +%H:%M:%S)] Starting..."
echo "Loading /app/env.sh"
. /app/env.sh

# Start main program loop
log_info "Entering main loop..."
while :; do
  sleep 1
done
