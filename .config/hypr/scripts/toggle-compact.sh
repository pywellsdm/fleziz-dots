#!/bin/bash

STATE_FILE="/tmp/hypr-compact-state"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hyprctl keyword decoration:rounding 10
    hyprctl keyword general:gaps_in 5
    hyprctl keyword general:gaps_out 20
else
    touch "$STATE_FILE"
    hyprctl keyword decoration:rounding 2
    hyprctl keyword general:gaps_in 2
    hyprctl keyword general:gaps_out 5
fi
