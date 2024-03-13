#!/bin/sh

usage() {
  echo "Usage: $CMDNAME -i IPADDRESS [-r VALUE] [-g VALUE] [-y VALUE] [-s STARTHOUR] [-e ENDHOUR]" 1>&2
  echo "Example: $CMDNAME -i 192.168.10.1 -r 1 -g 1 -y 0 -s 7 -e 21" 1>&2
  echo "r,g,y values mean 0:off, 1:on" 1>&2
  exit 1
}

# Parse input options
parse_options() {
  ip="192.168.10.1"
  value_r=1
  value_g=1
  value_y=1
  start_hour=0
  end_hour=24

  while getopts i:r:g:y:s:e: OPT
  do
    case $OPT in
      "i" ) ip="$OPTARG" ;;
      "r" ) value_r="${OPTARG}" ;;
      "g" ) value_g="${OPTARG}" ;;
      "y" ) value_y="${OPTARG}" ;;
      "s" ) start_hour="${OPTARG}" ;;
      "e" ) end_hour="${OPTARG}" ;;
        * ) usage ;;
    esac
  done
}

# Main logic
main() {
  current_hour=$(date +"%H")

  if [ "$current_hour" -lt "$start_hour" ] || [ "$current_hour" -gt "$end_hour" ]; then
    value_r=0
    value_g=0
    value_y=0
  fi

  hex_value=$(printf '%02X' "$((2#$value_g$value_y$value_r))")
  echo -ne '\x57\x'$hex_value | nc "$ip" 10000 || echo "Failed to connect to $ip" >&2
}

parse_options "$@"
main