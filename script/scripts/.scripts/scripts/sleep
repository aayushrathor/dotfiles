#!/bin/bash

while true; do
    # Get the current battery level and state
    battery_info=$(acpi)

    # Extract the numeric part of the battery level from the output of the acpi command
    battery_level=$(echo $battery_info | grep -Po '(\d+%)' | grep -Po '\d+')

    # Read the threshold values as integer values
    low_battery_threshold=10
    critical_battery_threshold=15

    # If the battery level is 15%, send a notification using dunst
    if [ $battery_level -eq $critical_battery_threshold ]; then
        dunstify -a "Low Battery" -u critical "The battery level is below 15%!"
    fi

    # If the battery level is below 10%, put the system into sleep mode
    if [ $battery_level -lt $low_battery_threshold ]; then
        systemctl suspend
    fi

    # Sleep for 60 seconds before checking the battery level again
    sleep 60
done
