# Miscellaneous functions are defined here

function setup_wifi() {
  # Bring up wifi interface
  log_info "Bringing up wifi interface...\
  `ifconfig $WLAN_INTERFACE up`"
  
  sleep 5

  # Scan local wifi networks
  log_info "Scanning wifi: 
  `iwlist $WLAN_INTERFACE s | grep 'Cell\|Quality\|ESSID\|IEEE'`"

  # Create file containing username and password for the wifi AP
  log_info "Creating wpa_supplicant.conf: 
  `echo $WLAN_PASSWORD | wpa_passphrase $CAM_NAME > /config/wpa_supplicant.conf`"

  # Listen for and connect to wifi whenever it is in range (process runs in background)
  log_info "Listen for and then connect to wifi: 
  `wpa_supplicant -B -i $WLAN_INTERFACE -c /config/wpa_supplicant.conf`"

  # Set IP address for wifi connection to device
  log_info "Setting IP address to $WLAN_IP... \
  `ip address flush dev $WLAN_INTERFACE && \
   ip address flush route $WLAN_INTERFACE && \
   ip address add $WLAN_IP/24 brd + dev wlp2s0 && \
   ip route add $CAM_IP dev $WLAN_INTERFACE`"  

  # Setup firewall rules to allow routing to camera device
  # Routing doesn't seem possible, maybe the camera won't allow connections from outside its subnet?

}

