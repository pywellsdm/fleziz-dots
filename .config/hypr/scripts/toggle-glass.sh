#!/bin/bash

STATE_FILE="/tmp/hypr-glass-state"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hyprctl keyword decoration:active_opacity 0.75
    hyprctl keyword decoration:inactive_opacity 0.85
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword decoration:blur:size 4
    ln -sf style-glass.css "$WAYBAR_STYLE"
else
    touch "$STATE_FILE"
    hyprctl keyword decoration:active_opacity 1.0
    hyprctl keyword decoration:inactive_opacity 1.0
    hyprctl keyword decoration:blur:enabled false
    ln -sf style-solid.css "$WAYBAR_STYLE"
fi

killall -9 waybar
waybar &
