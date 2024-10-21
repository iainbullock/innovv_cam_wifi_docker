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

# Create folder for camera files
if [ -d /data/$CAM_NAME ]; then
  mkdir -p /data/$CAM_NAME
  mkdir -p /data/$CAM_NAME/Protected
  mkdir -p /data/$CAM_NAME/Video
fi

# Start main program loop
log_info "Entering main loop..."
while :; do
  log_debug "Output from ifconfig: 
  `ifconfig $WLAN_INTERFACE`"

  log_debug "Output from iwconfig: 
  `iwconfig $WLAN_INTERFACE`"
  
  # Check if wifi is associated
  if [[ `iwconfig $WLAN_INTERFACE | grep -c ESSID:\"$CAM_NAME\"` -eq 0 ]]; then
    log_info "Wifi not associated"
  else
    log_info "Wifi associated, SSID is $CAM_NAME"
  fi
  
  sleep 5
  log_debug "  Next Loop..."
done
