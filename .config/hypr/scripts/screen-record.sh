#!/usr/bin/env bash

# Screen recording toggle script for wf-recorder + Hyprland
# Usage: screen-record.sh [screen|region|region-audio]

RECORDINGS_DIR="$HOME/Videos/Recordings"
PIDFILE="/tmp/wf-recorder.pid"

mkdir -p "$RECORDINGS_DIR"

# If already recording, stop it
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill -INT "$(cat "$PIDFILE")"
    wait "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
    notify-send -u low -i video-x-generic "Recording Stopped" "Saved to $RECORDINGS_DIR"
    exit 0
fi

# Build the filename
FILENAME="$RECORDINGS_DIR/Recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"

# Determine mode
MODE="${1:-screen}"

case "$MODE" in
    screen)
        wf-recorder -f "$FILENAME" &
        ;;
    region)
        GEOMETRY="$(slurp 2>/dev/null)" || exit 1
        wf-recorder -g "$GEOMETRY" -f "$FILENAME" &
        ;;
    region-audio)
        GEOMETRY="$(slurp 2>/dev/null)" || exit 1
        wf-recorder -g "$GEOMETRY" --audio -f "$FILENAME" &
        ;;
    *)
        notify-send -u critical "Screen Record" "Unknown mode: $MODE"
        exit 1
        ;;
esac

echo $! > "$PIDFILE"
notify-send -u low -i media-record "Recording Started" "$MODE mode"
