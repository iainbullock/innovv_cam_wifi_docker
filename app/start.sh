#!/bin/sh -e

# Initialise environment
echo "[$(date +%H:%M:%S)] Starting..."
echo "Loading /app/env.sh"
. /app/env.sh

# List Wireless Interfaces
log_info "Listing wireless interfaces:
  `iwconfig 2>/dev/null`"

# Setup wifi if required
[ -n "$WLAN_CONNECT" ] && setup_wifi

# Start main program loop
log_info "Entering main loop..."
while :; do
  log_debug "Output from ifconfig: 
  `ifconfig $WLAN_INTERFACE`"

  log_debug "Output from iwconfig: 
  `iwconfig $WLAN_INTERFACE`" 

  sleep 5
  log_debug "  Next Loop..."
done
