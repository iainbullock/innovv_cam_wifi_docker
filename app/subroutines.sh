# Miscellaneous functions are defined here

function setup_wifi() {
  # Scan local wifi networks
  log_info "Scanning wifi:
  `iwlist $WLAN_INTERFACE s | grep 'Cell\|Quality\|ESSID\|IEEE'`"

  # Create file containing username and password for the wifi AP
  echo $WLAN_PASSWORD | wpa_passphrase $WLAN_NAME > /config/wpa_supplicant.conf

  
}
