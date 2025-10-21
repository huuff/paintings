#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
WALLPAPER_DIR="$SCRIPT_DIR/img"
INTERVAL=${INTERVAL:-30}

while true; do
    IMAGE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    swww img "$IMAGE" --transition-type fade
    sleep "$INTERVAL"
done
