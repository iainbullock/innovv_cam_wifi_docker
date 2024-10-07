# Miscellaneous functions are defined here


# Scan local wifi networks
log_info "Scanning wifi:
  `iwlist  $WLAN_INTERFACE s | grep 'Cell\|Quality\|ESSID\|IEEE'"
