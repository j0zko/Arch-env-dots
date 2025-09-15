#!/bin/bash

# Try common browser player names if 'zen' isn't found
PLAYERS=("zen" "chromium" "firefox" "chrome" "youtube-music")

for PLAYER in "${PLAYERS[@]}"; do
  if playerctl -l | grep -qi "$PLAYER"; then
    PLAYER_NAME="$PLAYER"
    break
  fi
done

if [ -n "$PLAYER_NAME" ] && playerctl -p "$PLAYER_NAME" status &>/dev/null; then
  title=$(playerctl -p "$PLAYER_NAME" metadata title 2>/dev/null | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
  status=$(playerctl -p "$PLAYER_NAME" status 2>/dev/null)

  if [ "$status" = "Playing" ]; then
    echo "▶ ${title:0:50}" # Truncate long titles
  elif [ "$status" = "Paused" ]; then
    echo "⏸ ${title:0:50}"
  else
    echo ""
  fi
else
  echo ""
fi
