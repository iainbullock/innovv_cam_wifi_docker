function validateEnvVars() {
  exitOnError=0

  if [ "$DEBUG" != 'true' ] && [ "$DEBUG" != 'false' ]; then
    log_fatal "Fatal; DEBUG:$DEBUG is not compliant, please check this setting"
    exitOnError=1
  fi

  if [ $exitOnError -eq 0 ]; then
    rm -f /config/.exitOnError
  else
    touch /config/.exitOnError
    exit 99
  fi

}

# Setup logging
export COLOR=${COLOR:=true}
. /app/liblog.sh

# Validate environment variables
validateEnvVars
