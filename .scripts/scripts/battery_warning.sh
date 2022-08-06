#!/bin/bash
#batteryWarning

battery_stat="$(acpi --battery)"
battery_greped_status="$(echo $battery_stat | grep -Pio 'remaining|charged')"
battery_percentage_v="$(echo $battery_stat | grep -Po '(\d+%)' | grep -Po '\d+')"

if [ "$battery_greped_status" == "remaining" ]; then
        runtime="$(echo $battery_stat | grep -Po '[0-9]+:[0-9]+:[0-9]+')"

        if [ "$battery_percentage_v" -lt 15 ]; then
                dunstify -a system -i "/usr/share/icons/Papirus/48x48/status/notification-power.svg" -t 0 -r 9990 -u critical "Battery Critically Low" "${battery_percentage_v}% Remaining.\nRuntime: $runtime"
        fi

# Remind to disconnect charger if battery >=98%
elif [ "$battery_greped_status" == "charged" ]; then

    if [ "$battery_percentage_v" -ge 98 ]; then
        dunstify -a system -i "/usr/share/icons/Papirus/48x48/status/battery-full-charged.svg" -t 9000 -r 9990 -u normal "Battery ${battery_percentage_v}%" "Disconnect Charger please."
    fi
fi

