function validateEnvVars() {
  exitOnError=0

  if [ $exitOnError -eq 0 ]; then
    :
  else
    touch /config/.exitOnError
    exit 99
  fi

}


export COLOR=${COLOR:=true}
# Source Logging Library
. /app/liblog.sh

validateEnvVars
