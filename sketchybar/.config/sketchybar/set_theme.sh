#!/bin/bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
THEME_FILE="$CONFIG_DIR/.theme"
THEME_CONFIG="$CONFIG_DIR/theme_config.sh"

show_usage() {
  echo "Usage: $0 <theme_name|auto>"
  echo "  <theme_name>  - Set a specific theme and disable auto-switching"
  echo "  auto          - Re-enable auto theme switching"
  echo ""
  echo "Available themes:"
  ls -1 "$CONFIG_DIR/themes" | sed 's/.sh$//'
}

if [ -z "$1" ]; then
  show_usage
  exit 1
fi

THEME_NAME="$1"

if [ "$THEME_NAME" = "auto" ]; then
  sed -i '' 's/AUTO_SWITCH_ENABLED=.*/AUTO_SWITCH_ENABLED=true/' "$THEME_CONFIG"
  "$CONFIG_DIR/auto_theme.sh"
  echo "Auto theme switching enabled"
  exit 0
fi

if [ ! -f "$CONFIG_DIR/themes/$THEME_NAME.sh" ]; then
  echo "Theme '$THEME_NAME' not found"
  echo ""
  show_usage
  exit 1
fi

sed -i '' 's/AUTO_SWITCH_ENABLED=.*/AUTO_SWITCH_ENABLED=false/' "$THEME_CONFIG"
echo "$THEME_NAME" >"$THEME_FILE"
sketchybar --reload
echo "Switched to $THEME_NAME theme (auto-switching disabled)"

