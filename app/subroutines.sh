# Miscellaneous functions are defined here

function setup_wifi() {
  # Scan local wifi networks
  log_info "Scanning wifi:
    `iwlist  $WLAN_INTERFACE s | grep 'Cell\|Quality\|ESSID\|IEEE'`"
    
}
