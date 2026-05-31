#!/usr/bin/env bash

set -euo pipefail

action="${1:-}"
runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
state_dir="$runtime_dir/hypr-idle-brightness"
state_file="$state_dir/backlight"
lock_file="$state_dir/lock"
dim_value="${HYPRIDLE_DIM_BRIGHTNESS:-10}"

mkdir -p "$state_dir"

exec 9>"$lock_file"
flock 9

case "$action" in
    dim)
        if [[ ! -s "$state_file" ]]; then
            brightnessctl get > "$state_file"
        fi

        brightnessctl set "$dim_value" >/dev/null
        ;;
    restore)
        if [[ -s "$state_file" ]]; then
            read -r saved_brightness < "$state_file"

            if [[ "$saved_brightness" =~ ^[0-9]+$ ]]; then
                brightnessctl set "$saved_brightness" >/dev/null
            fi

            rm -f "$state_file"
        fi
        ;;
    *)
        printf 'usage: %s dim|restore\n' "$0" >&2
        exit 2
        ;;
esac
