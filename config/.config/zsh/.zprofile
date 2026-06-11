if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  # Prefer a uwsm-managed session: Hyprland runs as a systemd user unit, so
  # environment.d applies, the compositor logs to journald, and apps get a
  # proper graphical-session.target. Falls back to the plain wrapper if uwsm
  # is not installed.
  # Same invocation as the shipped hyprland-uwsm.desktop session entry.
  if command -v uwsm >/dev/null && uwsm check may-start; then
    exec uwsm start -e -D Hyprland hyprland.desktop
  fi
  exec start-hyprland
fi
