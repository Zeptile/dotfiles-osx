#!/bin/bash

THEMES_CONFIG_DIR="$HOME/.config/themes"
THEME_FILE="$THEMES_CONFIG_DIR/.theme"
THEMES_DIR="$THEMES_CONFIG_DIR/themes"
THEME_CONFIG="$THEMES_CONFIG_DIR/theme_config.sh"
GHOSTTY_CONFIG="$HOME/.config/ghostty/config"

source "$THEME_CONFIG"

if [ "$AUTO_SWITCH_ENABLED" != "true" ]; then
  return 0 2>/dev/null || exit 0
fi

if defaults read -g AppleInterfaceStyle &>/dev/null; then
  DESIRED_THEME="$DARK_THEME"
else
  DESIRED_THEME="$LIGHT_THEME"
fi

CURRENT_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "default")

if [ "$CURRENT_THEME" != "$DESIRED_THEME" ]; then
  source "$THEMES_DIR/$DESIRED_THEME.sh"
  echo "$DESIRED_THEME" > "$THEME_FILE"

  if [ -n "$GHOSTTY_THEME" ] && [ -f "$GHOSTTY_CONFIG" ]; then
    sed -i '' "s/^theme = .*/theme = $GHOSTTY_THEME/" "$GHOSTTY_CONFIG"
    pkill -USR2 ghostty 2>/dev/null || true
  fi

  if [ "$SKETCHYBAR_SOURCED" != "true" ]; then
    sketchybar --reload
  fi

  if [ -f "$HOME/.config/aerospace/reload_borders.sh" ]; then
    "$HOME/.config/aerospace/reload_borders.sh" >/dev/null 2>&1 &
  fi
fi
