local M = {}

local commands = {
    "waybar",
    "hyprpaper",
    "mako",
    "hypridle",
    "hyprsunset -t 3000",
    "systemctl --user start hyprpolkitagent",
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",
    "gsettings set org.gnome.desktop.interface cursor-size 16",
    "mpd",
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
}

function M.setup()
    hl.on("hyprland.start", function()
        for _, command in ipairs(commands) do
            hl.exec_cmd(command)
        end
    end)
end

return M
