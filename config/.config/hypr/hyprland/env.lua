-- Hybrid GPU/session environment.
-- Keep Hyprland on the integrated GPU; use prime-run for NVIDIA offload.
hl.env("XDG_SESSION_TYPE", "wayland")

-- Terminal for GUI apps such as Thunar.
hl.env("TERMINAL", "kitty")

-- Cursor.
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-- Qt theming.
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Electron Wayland.
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Font rendering is configured in ~/.config/environment.d/50-fonts.conf.
