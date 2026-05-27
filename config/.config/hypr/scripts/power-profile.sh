#!/usr/bin/env bash

set -euo pipefail

CURRENT=$(powerprofilesctl get)

build_menu() {
    local profiles=("performance" "balanced" "power-saver")
    local icons=("󱐋" "󰾅" "󰾆")
    local labels=("Performance" "Balanced" "Power Saver")

    for i in "${!profiles[@]}"; do
        local prefix="  "
        [[ "${profiles[$i]}" == "$CURRENT" ]] && prefix="› "
        printf "%s%s  %s\n" "$prefix" "${icons[$i]}" "${labels[$i]}"
    done
}

SELECTED=$(build_menu | fuzzel --dmenu --hide-prompt --only-match --lines 3 --width 24) || exit 0
[[ -z "$SELECTED" ]] && exit 0

case "$SELECTED" in
    *"Performance"*)  PROFILE="performance"  ;;
    *"Balanced"*)     PROFILE="balanced"     ;;
    *"Power Saver"*)  PROFILE="power-saver"  ;;
    *) exit 1 ;;
esac

[[ "$PROFILE" == "$CURRENT" ]] && exit 0

powerprofilesctl set "$PROFILE"
notify-send -u low -i battery "Power Profile" "Switched to $PROFILE"
