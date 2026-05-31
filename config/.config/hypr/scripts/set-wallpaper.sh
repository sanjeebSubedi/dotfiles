#!/usr/bin/env bash

set -euo pipefail

source_file="${1:-}"
runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
lock_file="$runtime_dir/set-wallpaper.lock"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/hypr"
wallpaper="$state_dir/wallpaper.jpg"
state_file="$state_dir/wallpaper-source"

notify() {
    command -v notify-send >/dev/null 2>&1 && timeout 5s notify-send "$@" >/dev/null 2>&1 || true
}

if [[ -z "$source_file" || ! -f "$source_file" ]]; then
    notify -u critical "Wallpaper" "No image selected"
    exit 1
fi

mkdir -p "$state_dir"

exec 9>"$lock_file"
flock -n 9 || exit 0

source_real="$(readlink -f -- "$source_file")"
wallpaper_real="$(readlink -f -- "$wallpaper" 2>/dev/null || true)"
source_state="$source_real|$(stat -c '%Y|%s' -- "$source_file")"

changed=false
mime_type="$(timeout 5s file --brief --mime-type -- "$source_file" 2>/dev/null || true)"

if [[ "$source_real" == "$wallpaper_real" ]]; then
    printf '%s\n' "$source_state" > "$state_file"
elif [[ -f "$wallpaper" && -f "$state_file" && "$(cat "$state_file")" == "$source_state" ]]; then
    :
elif [[ -f "$wallpaper" && "$mime_type" == "image/jpeg" ]] && timeout 10s cmp -s -- "$source_file" "$wallpaper"; then
    printf '%s\n' "$source_state" > "$state_file"
else
    tmp_wallpaper="$(mktemp --tmpdir="$runtime_dir" "wallpaper.XXXXXX.jpg")"
    trap 'rm -f "$tmp_wallpaper"' EXIT

    if command -v magick >/dev/null 2>&1; then
        if ! timeout 60s magick "$source_file" -auto-orient "$tmp_wallpaper"; then
            notify -u critical "Wallpaper" "Failed to prepare $(basename "$source_file")"
            exit 1
        fi
        chmod 0644 "$tmp_wallpaper"
        mv -f -- "$tmp_wallpaper" "$wallpaper"
    else
        install -m 0644 -- "$source_file" "$wallpaper"
    fi

    printf '%s\n' "$source_state" > "$state_file"
    changed=true
fi

if command -v hyprctl >/dev/null 2>&1 && pgrep -x hyprpaper >/dev/null 2>&1; then
    timeout 5s hyprctl hyprpaper wallpaper ",$wallpaper,cover" >/dev/null 2>&1 || true
fi

if [[ "$changed" == true ]]; then
    notify -u low "Wallpaper Updated" "$(basename "$source_file")"
fi
