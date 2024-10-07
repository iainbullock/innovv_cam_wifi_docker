#!/bin/sh -e

# Initialise environment
echo "[$(date +%H:%M:%S)] Starting..."
echo "Loading /app/env.sh"
. /app/env.sh

# View Interfaces
iwconfig 2>/dev/null | cat

# Start main program loop
log_info "Entering main loop..."
while :; do
  sleep 1
  log_info "  Next Loop..."
done
