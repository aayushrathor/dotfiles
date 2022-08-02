#!/bin/bash

# Terminate already running bar instances
killall -q polybar

#wait untill all bars are not closed
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini

# Command for top bar
echo "Top bar launched successfully ...."

polybar top 2>&1 | tee -a /tmp/polybar.log & disown

# Command for bottom bar
echo "bottom bar launched successfully ...."

polybar -c ~/.config/polybar/config.ini bottom -r &

echo "Both bars launched successfully ...."


