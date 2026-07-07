#!/bin/bash
# Toggle OLED-like screen shader on/off

SHADER="$HOME/.config/hypr/shaders/oled.glsl"
STATE_FILE="/tmp/hypr-oled-state"

if [ -f "$STATE_FILE" ]; then
    hyprctl keyword decoration:screen_shader "" 2>&-
    rm "$STATE_FILE"
    notify-send "OLED Mode" "Disabled" -t 1500
else
    hyprctl keyword decoration:screen_shader "$SHADER" 2>&-
    touch "$STATE_FILE"
    notify-send "OLED Mode" "Enabled" -t 1500
fi
