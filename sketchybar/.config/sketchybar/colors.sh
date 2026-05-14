#!/bin/bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
THEME_FILE="$CONFIG_DIR/.theme"
THEME_DIR="$CONFIG_DIR/themes"

if [ ! -f "$THEME_FILE" ]; then
  echo "default" >"$THEME_FILE"
fi

CURRENT_THEME=$(cat "$THEME_FILE")

if [ -f "$THEME_DIR/$CURRENT_THEME.sh" ]; then
  source "$THEME_DIR/$CURRENT_THEME.sh"
else
  source "$THEME_DIR/default.sh"
fi

