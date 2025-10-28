#!/usr/bin/env bash

# Find the battery (will be empty on desktops)
BATTERY_PATH=$(upower -e | grep 'BAT')

# If no battery is found, just run the command
# (This makes the script safe for desktops)
if [ -z "$BATTERY_PATH" ]; then
    bash -c "$*"
    exit 0
fi

# Get the battery state
STATE=$(upower -i $BATTERY_PATH | grep "state" | awk '{print $2}')

if [ "$STATE" = "discharging" ]; then
    # If discharging (on battery), run the idle command
    bash -c "$*"
else
    # If charging or full, do nothing
    exit 0
fi
