#!/bin/sh
# Toggle wlogout: close it if it is already open, otherwise launch it with
# margins computed from the focused monitor so the single row of 5 buttons
# stays centered and square on any output.

if pkill -x wlogout; then
    exit 0
fi

# Logical (scaled) size of the focused monitor.
set -- $(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.width / .scale | floor) \(.height / .scale | floor)"')
width=$1
height=$2

# Target button row: ~1600x340 logical px (buttons ~300x320 after margins).
row_w=1600
row_h=340
lr=$(( (width - row_w) / 2 ))
tb=$(( (height - row_h) / 2 ))
[ "$lr" -lt 0 ] && lr=0
[ "$tb" -lt 0 ] && tb=0

exec wlogout -b 5 --protocol layer-shell -L "$lr" -R "$lr" -T "$tb" -B "$tb"
