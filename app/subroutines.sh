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
  `wpa_supplicant -B -i $WLAN_INTERFACE -c /config/wpa_supplicant.conf -D $WPA_DRIVER`"

  # Get IP address from device via dhcp (process runs in background)
  log_info "Get IP address from device via dhcp...\
  `dhclient $WLAN_INTERFACE`"  
}

function setup_firewall() {
  # Set up firewall to allow routing to / from camera device
  log_debug "Setting up firewall rules. Ignore messages like iptables: Bad rule (does a matching rule exist in that chain?)..."
  iptables-nft -C FORWARD -o $WLAN_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT || iptables-nft -A FORWARD -o $WLAN_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables-nft -C FORWARD -i $WLAN_INTERFACE -j ACCEPT || iptables-nft -A FORWARD -i $WLAN_INTERFACE -j ACCEPT
  iptables-nft -C FORWARD -p icmp -j ACCEPT || iptables-nft -A FORWARD -p icmp -j ACCEPT  
}

function restore_firewall() {
  # Remove firewall rules which were added to allow routing to / from camera device
  log_debug "Restoring firewall rules..."
  iptables-nft -C FORWARD -o $WLAN_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT && iptables-nft -D FORWARD -o $WLAN_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables-nft -C FORWARD -i $WLAN_INTERFACE -j ACCEPT && iptables-nft -D FORWARD -i $WLAN_INTERFACE -j ACCEPT
  iptables-nft -C FORWARD -p icmp -j ACCEPT && iptables-nft -D FORWARD -p icmp -j ACCEPT
}

