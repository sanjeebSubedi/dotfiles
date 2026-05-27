#!/usr/bin/env bash

# Screen recording toggle script for wf-recorder + Hyprland
# Usage: screen-record.sh [screen|region|region-audio]

RECORDINGS_DIR="$HOME/Videos/Recordings"
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"

mkdir -p "$RECORDINGS_DIR"

stop_recording() {
    local pid="$1"

    kill -INT "$pid"
    for _ in {1..50}; do
        kill -0 "$pid" 2>/dev/null || return 0
        sleep 0.1
    done

    return 1
}

if [ -f "$PIDFILE" ]; then
    RECORDER_PID="$(cat "$PIDFILE" 2>/dev/null || true)"
    if [ -n "$RECORDER_PID" ] && kill -0 "$RECORDER_PID" 2>/dev/null; then
        if stop_recording "$RECORDER_PID"; then
            notify-send -u low -i video-x-generic "Recording Stopped" "Saved to $RECORDINGS_DIR"
        else
            notify-send -u normal -i video-x-generic "Recording Stop Requested" "wf-recorder is still shutting down"
        fi
        rm -f "$PIDFILE"
        exit 0
    fi

    rm -f "$PIDFILE"
fi

FILENAME="$RECORDINGS_DIR/Recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"
MODE="${1:-screen}"
WF_RECORDER=(wf-recorder -f "$FILENAME")

case "$MODE" in
    screen)
        ;;
    region)
        GEOMETRY="$(slurp 2>/dev/null)" || exit 1
        WF_RECORDER=(wf-recorder -g "$GEOMETRY" -f "$FILENAME")
        ;;
    region-audio)
        GEOMETRY="$(slurp 2>/dev/null)" || exit 1
        WF_RECORDER=(wf-recorder -g "$GEOMETRY" --audio -f "$FILENAME")
        ;;
    *)
        notify-send -u critical "Screen Record" "Unknown mode: $MODE"
        exit 1
        ;;
esac

"${WF_RECORDER[@]}" &
echo "$!" > "$PIDFILE"
notify-send -u low -i media-record "Recording Started" "$MODE mode"
