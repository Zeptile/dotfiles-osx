#!/bin/bash

MEDIA_INFO=""

MEDIA_INFO=$(swift "${0%/*}/nowplaying.swift" 2>/dev/null)

if [ -z "$MEDIA_INFO" ] || [ "$MEDIA_INFO" = " – " ] || [ "$MEDIA_INFO" = "null – null" ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" icon="󰎆" label="$MEDIA_INFO" drawing=on
fi

