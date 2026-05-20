#!/bin/bash

THEMES_CONFIG_DIR="$HOME/.config/themes"
THEME_FILE="$THEMES_CONFIG_DIR/.theme"
THEME_DIR="$THEMES_CONFIG_DIR/themes"

if [ ! -f "$THEME_FILE" ]; then
  echo "default" > "$THEME_FILE"
fi

CURRENT_THEME=$(cat "$THEME_FILE")

if [ -f "$THEME_DIR/$CURRENT_THEME.sh" ]; then
  source "$THEME_DIR/$CURRENT_THEME.sh"
else
  source "$THEME_DIR/default.sh"
fi
