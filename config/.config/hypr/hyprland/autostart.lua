local M = {}

local commands = {
	-- Export session vars to D-Bus and systemd activation env first, so XDG
	-- portals and polkit agents inherit WAYLAND_DISPLAY / XDG_CURRENT_DESKTOP.
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",

	-- Core compositor services.
	"waybar",
	"hyprpaper",
	"mako",
	"hypridle",
	"hyprsunset",
	"systemctl --user start hyprpolkitagent",

	-- Clipboard history (wl-clipboard + cliphist).
	"wl-paste --type text --watch cliphist store",
	"wl-paste --type image --watch cliphist store",

	-- GTK cursor size (must match XCURSOR_SIZE / HYPRCURSOR_SIZE in env.lua).
	"gsettings set org.gnome.desktop.interface cursor-size 20",

	-- mpd is managed via systemd socket activation (mpd.socket).
	-- Enable once with: systemctl --user enable --now mpd.socket
}

function M.setup()
	hl.on("hyprland.start", function()
		for _, command in ipairs(commands) do
			hl.exec_cmd(command)
		end
	end)
end

return M
