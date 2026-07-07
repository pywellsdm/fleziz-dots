#!/bin/bash

# Define the wallpaper path from the argument
WALLPAPER="$1"

# 1. Run Matugen with absolute path
/usr/bin/matugen -m dark image "$WALLPAPER" -t scheme-vibrant --source-color-index 0

# 2. Refresh Waybar
/usr/bin/killall -SIGUSR2 waybar

# 3. Refresh Kitty
/usr/bin/killall -SIGUSR1 kitty

# 4. Optional: Log errors to a file so we can see what's happening
echo "Changed wallpaper to $WALLPAPER at $(date)" >> /tmp/waypaper_refresh.log
