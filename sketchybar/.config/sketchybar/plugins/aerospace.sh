#!/bin/bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  FOCUSED_WORKSPACE_ID=$(aerospace list-workspaces --focused)
  VISIBLE_WORKSPACES=$(aerospace list-workspaces --monitor all --visible)
  
  if [ "$1" = "$FOCUSED_WORKSPACE_ID" ]; then
    sketchybar --set "$NAME" \
      background.border_width=2 \
      background.border_color=$WORKSPACE_FOCUSED_BORDER
  elif echo "$VISIBLE_WORKSPACES" | grep -q "^$1$"; then
    sketchybar --set "$NAME" \
      background.border_width=2 \
      background.border_color=$WORKSPACE_VISIBLE_BORDER
  else
    sketchybar --set "$NAME" \
      background.border_width=1 \
      background.border_color=$WORKSPACE_INACTIVE_BORDER
  fi
fi
