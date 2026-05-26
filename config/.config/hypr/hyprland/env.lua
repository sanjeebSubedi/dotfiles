-- NVIDIA hybrid GPU/session environment.
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

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
