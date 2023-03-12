#!/bin/sh

DEVICE=$(bluetoothctl info | grep 'Name' | cut -d ' ' -f 2-)

if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#ABC9FF}"
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    echo ""
  else
    echo "%{F#2193ff} $DEVICE"
  fi
fi
