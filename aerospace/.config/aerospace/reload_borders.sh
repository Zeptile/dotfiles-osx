#!/bin/bash

# Pull border colors/width from the active theme so window borders
# stay in sync with the rest of the theme system.
THEMES_CONFIG_DIR="$HOME/.config/themes"
THEME_FILE="$THEMES_CONFIG_DIR/.theme"
THEMES_DIR="$THEMES_CONFIG_DIR/themes"

CURRENT_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "default")

if [ -f "$THEMES_DIR/$CURRENT_THEME.sh" ]; then
  source "$THEMES_DIR/$CURRENT_THEME.sh"
fi

# Fall back to sensible defaults if the theme doesn't define them.
ACTIVE_COLOR=${WORKSPACE_FOCUSED_BORDER:-0xff9d0006}
INACTIVE_COLOR=${WORKSPACE_INACTIVE_BORDER:-0xff504945}
WIDTH=${BORDER_WIDTH:-4.0}

killall borders 2>/dev/null
borders active_color=$ACTIVE_COLOR inactive_color=$INACTIVE_COLOR width=$WIDTH &
