#!/bin/sh

#sample
# ./network_patlite.sh -ip192.168.1.2 -g0 -y1 -r0 -s9 -e18

if [ $# -lt 1 ]; then
  echo "$# parameter." 1>&2
  echo "You need more than 1 parameter." 1>&2
  echo "Usage: $CMDNAME -iIPADDRESS [-r VALUE] [-g VALUE] [-y VALUE] [-s STARTHOUR] [-e ENDHOUR]" 1>&2
  echo "Example: $CMDNAME -i192.168.1.2 -r1 -g1 -y0 -s7 -e21" 1>&2
  #echo "0:off, 1:on, 2:blink" 1>&2
  echo "0:off, 1:on" 1>&2
  exit 1
fi

while getopts i:r:g:y:s:e: OPT
do
  case $OPT in
    "i" ) IP="$OPTARG" ;;
    "r" ) FLG_R="TRUE" ; VALUE_R="$OPTARG" ;;
    "g" ) FLG_G="TRUE" ; VALUE_G="$OPTARG" ;;
    "y" ) FLG_Y="TRUE" ; VALUE_Y="$OPTARG" ;;
    "s" ) START_HOUR="$OPTARG" ;;
    "e" ) END_HOUR="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
          #echo "0:off, 1:on, 2:blink" 1>&2
          echo "0:off, 1:on" 1>&2
          exit 1 ;;
  esac
done

CURRENT_HOUR=$(date +"%H")

if [ "$CURRENT_HOUR" -lt "$START_HOUR" ] || [ "$CURRENT_HOUR" -gt "$END_HOUR" ]; then
  VALUE_R=""
  VALUE_G=""
  VALUE_Y=""
fi

echo -ne '\x57\x'$(echo "obase=16;ibase=2;00000${VALUE_G}${VALUE_Y}${VALUE_R}" | bc) | nc ${IP} 10000
