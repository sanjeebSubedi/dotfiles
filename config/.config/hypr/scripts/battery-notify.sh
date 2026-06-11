#!/bin/sh
# Low-battery notifier, run periodically by battery-notify.timer.
# Notifies once per tier (20% normal, 10% critical) while discharging;
# plugging in resets the tiers. Mako styles urgency=critical in red.

bat=/sys/class/power_supply/BAT0
state_file="${XDG_RUNTIME_DIR:-/tmp}/battery-notify-tier"

[ -r "$bat/capacity" ] || exit 0

status=$(cat "$bat/status")
capacity=$(cat "$bat/capacity")

if [ "$status" != "Discharging" ]; then
    rm -f "$state_file"
    exit 0
fi

last_tier=$(cat "$state_file" 2>/dev/null || echo 100)

if [ "$capacity" -le 10 ] && [ "$last_tier" -gt 10 ]; then
    notify-send -u critical -i battery-caution \
        "Battery critical: ${capacity}%" "Plug in now or suspend."
    echo 10 > "$state_file"
elif [ "$capacity" -le 20 ] && [ "$last_tier" -gt 20 ]; then
    notify-send -u normal -i battery-low \
        "Battery low: ${capacity}%" "Consider plugging in."
    echo 20 > "$state_file"
fi
