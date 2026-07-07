#!/bin/bash

killall -9 waybar

STYLE_DIR="$HOME/.config/waybar"
STATE_FILE="/tmp/hypr-glass-state"

if [ -f "$STATE_FILE" ]; then
    ln -sf style-solid.css "$STYLE_DIR/style.css"
else
    ln -sf style-glass.css "$STYLE_DIR/style.css"
fi

waybar &

