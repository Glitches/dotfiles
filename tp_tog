#!/bin/sh
TOGGLE=$(xinput --list-props 14 | grep 'Device Enabled (176):' | cut -d ' ' -f 3 | cut -d ':' -f 2 | grep -q '1'; echo $?)

if [ "$TOGGLE" -eq 0 ]; then
    xinput disable 14
    notify-send -u low -i mouse --icon=/usr/share/icons/HighContrast/256x256/status/touchpad-disabled.png "Trackpad disabled"
    synclient TouchpadOff=1
else
    xinput enable 14
    notify-send -u low -i mouse --icon=/usr/share/icons/HighContrast/256x256/devices/input-touchpad.png "Trackpad enabled"
    synclient TouchpadOff=0
fi
