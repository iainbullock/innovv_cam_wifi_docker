# Initialise config variable defaults
export DEBUG=${DEBUG:-false}

# Setup logging and validate environment variables
echo "[$(date +%H:%M:%S)] Loading libproduct.sh"
. /app/libproduct.sh

# Load functions
log_debug "Loading functions..."
for fSource in subroutines.sh \
  version.sh; do
  if [ -f /app/$fSource ]; then
    log_debug "Loading /app/$fSource"
    . /app/$fSource
  else
    echo "Fatal error; file not found $fSource"
    exit 10
  fi
done

# Log Config Variables
log_info "Configuration Options are:
  DEBUG=$DEBUG
  WLAN_CONNECT=$WLAN_CONNECT
  CAM_NAME=$CAM_NAME
  CAM_IP=$CAM_IP"

[ -n "$WLAN_CONNECT" ] && log_info "  WLAN_INTERFACE=$WLAN_INTERFACE
  WLAN_PASSWORD=$WLAN_PASSWORD
  WLAN_INTERFACE=$WLAN_INTERFACE
