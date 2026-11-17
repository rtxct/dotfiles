#!/bin/bash

old_title=$(playerctl metadata --format '{{ title }}' 2>/dev/null)
playerctl "$1"

if [[ "$1" == "next" || "$1" == "previous" ]]; then
    # Wait up to 2 seconds for the track title to actually change
    for _ in {1..20}; do
        cur_title=$(playerctl metadata --format '{{ title }}' 2>/dev/null)
        [[ -n "$cur_title" && "$cur_title" != "$old_title" ]] && break
        sleep 0.1
    done
else
    sleep 0.15
fi

player=$(playerctl metadata --format '{{ playerName }}' 2>/dev/null)
title=$(playerctl metadata --format '{{ title }}' 2>/dev/null)
artist=$(playerctl metadata --format '{{ artist }}' 2>/dev/null)
art_url=$(playerctl metadata --format '{{ mpris:artUrl }}' 2>/dev/null)

if [[ "$art_url" == file://* ]]; then
    icon="${art_url#file://}"
else
    # Strip anything after a dot (e.g., firefox.instance123 -> firefox)
    icon="${player%%.*}"
    icon="${icon:-audio-x-generic}"
fi

notify-send -a "Media" \
    -h string:x-canonical-private-synchronous:media \
    -i "$icon" \
    "${title:-No Media}" \
    "$artist"
