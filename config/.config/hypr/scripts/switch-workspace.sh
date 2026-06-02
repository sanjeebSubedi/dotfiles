#!/usr/bin/env bash

set -euo pipefail

workspace="${1:-}"

case "$workspace" in
    [1-9]|10) ;;
    *)
        printf 'usage: %s <1-10>\n' "$0" >&2
        exit 2
        ;;
esac

if hyprctl monitors -j | grep -q '"name": "special:hidden"'; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("hidden")' >/dev/null
fi

hyprctl dispatch "hl.dsp.focus({ workspace = $workspace })" >/dev/null
