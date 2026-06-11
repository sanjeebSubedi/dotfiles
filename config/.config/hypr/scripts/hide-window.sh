#!/usr/bin/env bash

set -euo pipefail

current_workspace="$(hyprctl activeworkspace -j | jq -r '.id')"

hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:hidden", silent = true })' >/dev/null

if hyprctl monitors -j | jq -e 'any(.[]; .specialWorkspace.name == "special:hidden")' >/dev/null; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("hidden")' >/dev/null
fi

case "$current_workspace" in
    [1-9]|10)
        hyprctl dispatch "hl.dsp.focus({ workspace = $current_workspace })" >/dev/null
        ;;
esac
