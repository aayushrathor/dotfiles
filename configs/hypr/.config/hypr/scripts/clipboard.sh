#!/bin/sh

if [[ ! `pgrep -f "kitty --class clipse -e clipse"` ]]; then
  kitty --class clipse -e clipse
else
  pkill -9 -f "kitty --class clipse -e clipse"
fi
