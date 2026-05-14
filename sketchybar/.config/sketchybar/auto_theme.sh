#!/bin/bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
THEME_FILE="$CONFIG_DIR/.theme"

source "$CONFIG_DIR/theme_config.sh"

if [ "$AUTO_SWITCH_ENABLED" != "true" ]; then
  return 0 2>/dev/null || exit 0
fi

if defaults read -g AppleInterfaceStyle &>/dev/null; then
  SYSTEM_APPEARANCE="dark"
  DESIRED_THEME="$DARK_THEME"
else
  SYSTEM_APPEARANCE="light"
  DESIRED_THEME="$LIGHT_THEME"
fi

CURRENT_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "default")

if [ "$CURRENT_THEME" != "$DESIRED_THEME" ]; then
  echo "$DESIRED_THEME" >"$THEME_FILE"
  if [ "$SKETCHYBAR_SOURCED" != "true" ]; then
    sketchybar --reload
  fi
fi

