#!/usr/bin/env bash

# 1. Kill any previous waiting instances of this script
for pid in $(pgrep -f "${BASH_SOURCE[0]}"); do
    [[ "$pid" != "$$" && "$pid" != "$PPID" ]] && kill "$pid" 2>/dev/null
done

# 2. Pick the most relevant active player (prefers currently Playing over Paused)
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)
for p in $(playerctl -l 2>/dev/null); do
    if [[ "$(playerctl -p "$p" status 2>/dev/null)" == "Playing" ]]; then
        PLAYER="$p"
        break
    fi
done

if [[ -z "$PLAYER" ]]; then
    notify-send -a "Media" -h string:x-canonical-private-synchronous:media -i "audio-x-generic" "No Media" "No active player found"
    exit 0
fi

# 3. Record state BEFORE running the command on that specific player
old_status=$(playerctl -p "$PLAYER" status 2>/dev/null)
old_title=$(playerctl -p "$PLAYER" metadata --format '{{ title }}' 2>/dev/null)

# 4. Execute the media action on the SAME player
playerctl -p "$PLAYER" "$1"

# 5. Wait up to 1.5s for the status or title on that player to actually update
for _ in {1..30}; do
    cur_status=$(playerctl -p "$PLAYER" status 2>/dev/null)
    cur_title=$(playerctl -p "$PLAYER" metadata --format '{{ title }}' 2>/dev/null)
    if [[ "$1" == "play-pause" && "$cur_status" != "$old_status" ]]; then
        break
    elif [[ "$1" != "play-pause" && -n "$cur_title" && "$cur_title" != "$old_title" ]]; then
        break
    fi
    sleep 0.05
done

# 6. Fetch metadata directly from that player (separate calls are ~2ms and avoid tab-collapsing bugs)
status=$(playerctl -p "$PLAYER" status 2>/dev/null)
player_name=$(playerctl -p "$PLAYER" metadata --format '{{ playerName }}' 2>/dev/null)
title=$(playerctl -p "$PLAYER" metadata --format '{{ title }}' 2>/dev/null)
artist=$(playerctl -p "$PLAYER" metadata --format '{{ artist }}' 2>/dev/null)
art_url=$(playerctl -p "$PLAYER" metadata --format '{{ mpris:artUrl }}' 2>/dev/null)

# 7. Resolve icon (local album art first, otherwise app icon)
if [[ "$art_url" == file://* ]]; then
    icon="${art_url#file://}"
else
    icon="${player_name%%.*}"
    icon="${icon:-audio-x-generic}"
fi

# 8. Set status prefix
case "$status" in
    Playing) prefix="▶ Playing" ;;
    Paused)  prefix="⏸ Paused" ;;
    *)       prefix="$status" ;;
esac

notify-send -a "Media" \
    -h string:x-canonical-private-synchronous:media \
    -i "$icon" \
    "$prefix: ${title:-Unknown Track}" \
    "${artist}"
