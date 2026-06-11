#!/bin/sh
# Open bluetui, lifting any rfkill soft-block first so the adapter
# can actually be powered on from inside the TUI.
rfkill unblock bluetooth
exec kitty --class bluetui-float -e bluetui
