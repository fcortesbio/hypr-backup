#!/bin/bash

# Check if AC adapter is connected
if cat /sys/class/power_supply/A*/online 2>/dev/null | grep -q 1; then
    # Charging - disable screen timeout
    pkill swayidle
else
    # On battery - enable screen timeout (10 minutes)
    swayidle -w \
        timeout 600 'hyprctl dispatch dpms off' \
        resume 'hyprctl dispatch dpms on' &
fi