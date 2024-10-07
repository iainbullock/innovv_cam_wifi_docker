# Load Functions
echo "[$(date +%H:%M:%S)] loading libproduct.sh"
. /app/libproduct.sh
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

# Initialise environment with default value if empty string is provided
export DEBUG=${DEBUG:-false}

### LOG CONFIG VARS ###########################################################
log_info "Configuration Options are:
  DEBUG=$DEBUG
  "

[ -n "$ENABLE_HA_FEATURES" ] && log_info "  ENABLE_HA_FEATURES=$ENABLE_HA_FEATURES"
[ -n "$BLECTL_FILE_INPUT" ] && log_info "  BLECTL_FILE_INPUT=$BLECTL_FILE_INPUT"
