# Miscellaneous functions are defined here

function setup_wifi() {
  # Bring up wifi interface
  log_info "Bringing up wifi interface...\
  `ifconfig $WLAN_INTERFACE up`"
  
  # Scan local wifi networks
  log_info "Scanning wifi: \
  `iwlist $WLAN_INTERFACE s | grep 'Cell\|Quality\|ESSID\|IEEE'`"

  # Create file containing username and password for the wifi AP
  log_info "Creating wpa_supplicant.conf: \
  `echo $WLAN_PASSWORD | wpa_passphrase $WLAN_NAME > /config/wpa_supplicant.conf`"

  # Listen for and connect to wifi whenever it is in range (process runs in background)
  log_info "Listen for and then connect to wifi: \
  `wpa_supplicant -B -i $WLAN_INTERFACE -c /config/wpa_supplicant.conf -D $WPA_DRIVER`"

  # Get IP address from device via dhcp (process runs in background)
  log_info "Get IP address from device via dhcp...\
  `dhclient $WLAN_INTERFACE`"  
}
