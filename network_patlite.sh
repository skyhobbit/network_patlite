#!/bin/sh

# sample
# ./network_patlite.sh -i 192.168.1.2 -r 1 -g 1 -y 0 -s 7 -e 21

# Usage message
usage() {
  echo "Usage: $CMDNAME -i IPADDRESS [-r VALUE] [-g VALUE] [-y VALUE] [-s STARTHOUR] [-e ENDHOUR]" 1>&2
  echo "Example: $CMDNAME -i 192.168.1.2 -r 1 -g 1 -y 0 -s 7 -e 21" 1>&2
  echo "r,g,y are values mean 0:off, 1:on" 1>&2
  exit 1
}

# Validate input parameters
validate_params() {
  if [ $# -lt 2 ]; then
    echo "$# parameter." 1>&2
    echo "You need more than 2 parameters." 1>&2
    usage
  fi
}

# Parse input options
parse_options() {
  while getopts i:r:g:y:s:e: OPT
  do
    case $OPT in
      "i" ) IP="$OPTARG" ;;
      "r" ) VALUE_R="$OPTARG" ;;
      "g" ) VALUE_G="$OPTARG" ;;
      "y" ) VALUE_Y="$OPTARG" ;;
      "s" ) START_HOUR="$OPTARG" ;;
      "e" ) END_HOUR="$OPTARG" ;;
        * ) usage ;;
    esac
  done
}

# Main logic
main() {
  CURRENT_HOUR=$(date +"%H")

  if [ "$CURRENT_HOUR" -lt "$START_HOUR" ] || [ "$CURRENT_HOUR" -gt "$END_HOUR" ]; then
    VALUE_R=""
    VALUE_G=""
    VALUE_Y=""
  fi

  echo -ne '\x57\x'$(echo "obase=16;ibase=2;00000${VALUE_G}${VALUE_Y}${VALUE_R}" | bc) | nc ${IP} 10000
}

validate_params "$@"
parse_options "$@"
main
