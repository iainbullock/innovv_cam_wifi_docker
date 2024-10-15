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
[ -d /config/$CAM_NAME ] || mkdir /config/$CAM_NAME

# Setup firewall rules to allow routing to camera device
setup_firewall

# Start main program loop
log_info "Entering main loop..."
while :; do
  log_debug "Output from ifconfig: 
  `ifconfig $WLAN_INTERFACE`"

  log_debug "Output from iwconfig: 
  `iwconfig $WLAN_INTERFACE`"
  
  # Check if wifi is associated
  if [[ `iwconfig $WLAN_INTERFACE | grep -c ESSID:\"$WLAN_NAME\"` -eq 0 ]]; then
    log_info "Wifi not associated"
  else
    log_info "Wifi associated, SSID is $WLAN_NAME"
  fi
  
  sleep 5
  log_debug "  Next Loop..."
done
