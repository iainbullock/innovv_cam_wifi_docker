# Initialise config variable defaults
export DEBUG=${DEBUG:-false}

# Setup logging and validate environment variables
echo "[$(date +%H:%M:%S)] loading libproduct.sh"
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
  WLAN_CONNECT=$WLAN_CONNECT"

[ -n "$WLAN_CONNECT" ] && log_info "  WLAN_INTERFACE=$WLAN_INTERFACE"; \
log_info "  WLAN_NAME=$WLAN_NAME"; \
log_info "  WLAN_PASSWORD=$WLAN_PASSWORD"; \
log_info "  WLAN_DRIVER=$WLAN_DRIVER"
