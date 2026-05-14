#!/bin/bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
THEME_FILE="$CONFIG_DIR/.theme"
THEME_CONFIG="$CONFIG_DIR/theme_config.sh"

source "$THEME_CONFIG"

CURRENT_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "default")

if [ "$CURRENT_THEME" = "$DARK_THEME" ]; then
  NEW_THEME="$LIGHT_THEME"
else
  NEW_THEME="$DARK_THEME"
fi

sed -i '' 's/AUTO_SWITCH_ENABLED=.*/AUTO_SWITCH_ENABLED=false/' "$THEME_CONFIG"
echo "$NEW_THEME" >"$THEME_FILE"
sketchybar --reload

echo "Switched to $NEW_THEME theme (auto-switching disabled)"

