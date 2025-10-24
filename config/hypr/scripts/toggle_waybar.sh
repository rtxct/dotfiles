#!/usr/bin/env bash

WAYBAR_BIN="$(command -v waybar)"
[ -n "$WAYBAR_BIN" ] || { echo "waybar not found in PATH"; exit 1; }

if pgrep -x waybar >/dev/null; then
  # stop
  pkill -x waybar
else
  # start detached so it doesn't die with the shell
  nohup "$WAYBAR_BIN" >/dev/null 2>&1 &
fi
