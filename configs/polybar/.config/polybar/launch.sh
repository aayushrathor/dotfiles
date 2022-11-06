#!/bin/bash

# Terminate already running bar instances
killall -q polybar

#wait untill all bars are not closed
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "Polybar killed"
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini

# Command for top bar
polybar -c ~/.config/polybar/config.ini top -r &
echo "Top bar launched successfully"

# Command for bottom bar
polybar -c ~/.config/polybar/config.ini bottom -r &
echo "bottom bar launched successfully"

# Command for system tray
polybar -c ~/.config/polybar/config.ini systray -r &
echo "system tray launched successfully"

echo "Bars Launched Successfully"
notify-send -u NORMAL -t 1500 "Bars Launched Successfully"
