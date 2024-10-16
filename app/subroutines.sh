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

function download() {
  # curl should be quiet unless in debug mode
  if [ $DEBUG != "true" ]; then
    quiet_args="--no-progress-meter"
  fi

  echo "Downloading latest file list"
  curl --output /data/$CAM_NAME/filelist $quiet_args "http://192.168.1.254/?custom=1&cmd=3015"
  rv=$?
  if [ $rv -ne 0 ]; then
    echo "Downloading file list failed (error code $rv)"
    rm -f /data/$CAM_NAME/filelist
    exit 1
  else
    ls -al /data/$CAM_NAME/filelist
  fi

    # Get SD card volume name
  volume_name=`cat /data/$CAM_NAME/filelist | grep -m 1 '<FPATH>A:' | cut -d '\' -f 2`
  if [ ${#volume_name} -eq 0 ]; then
    echo "Invalid SD card volume name: $volume_name"
    exit 2
  else
    echo "SD Card volume name: $volume_name"
  fi

  echo "Searching for standard videos"
  cat /data/$CAM_NAME/filelist | grep '<FPATH>A:\\$volume_name\\VIDEO' | cut -d '\' -f 4 | cut -d '<' -f 1 | while read -r fi
    echo -e Downloading video: $file
    curl --output /data/$CAM_NAME/$file $quiet_args "http://$CAM_IP/$volume_name/VIDEO/$file"
    rv=$?
    [ $rv -ne 0 ] && echo "Downloading video failed (error code $rv)" && rm -f /data/$CAM_NAME/$file && exit 3
    if [ $rv -ne 0 ]; then
      echo "Downloading video failed (error code $rv)"
      rm -f /data/$CAM_NAME/$file
      exit 3
    else
      ls -al /data/$CAM_NAME/$file
    fi

    echo "Deleting $file"
    curl $quiet_args "http://$CAM_IP/$volume_name/VIDEO/$file?del=1"
    rv=$?
    echo -e Result was $rv

done

}