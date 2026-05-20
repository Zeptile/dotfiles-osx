#!/bin/bash

THEMES_CONFIG_DIR="$HOME/.config/themes"
THEME_FILE="$THEMES_CONFIG_DIR/.theme"
THEME_CONFIG="$THEMES_CONFIG_DIR/theme_config.sh"

source "$THEME_CONFIG"

CURRENT_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "default")

if [ "$CURRENT_THEME" = "$DARK_THEME" ]; then
  NEW_THEME="$LIGHT_THEME"
else
  NEW_THEME="$DARK_THEME"
fi

"$HOME/.local/bin/set_theme" "$NEW_THEME"
