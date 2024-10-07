# Miscellaneous functions are defined here


# Scan local networks
iwlist  $WLAN_INTERFACE s | grep 'Cell\|Quality\|ESSID\|IEEE'
