local M = {}

local commands = {
	-- Under uwsm the compositor unit is Type=notify and *waits* for this:
	-- finalize exports WAYLAND_DISPLAY/DISPLAY (plus the listed vars) to the
	-- systemd/D-Bus activation env and signals unit readiness. Harmless no-op
	-- in a non-uwsm session.
	"sh -c 'command -v uwsm >/dev/null && exec uwsm finalize HYPRLAND_INSTANCE_SIGNATURE XCURSOR_SIZE XCURSOR_THEME'",

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

	-- GTK font settings: under Hyprland GTK reads gsettings (via the settings
	-- portal), not gtk-3.0/settings.ini, so keep these in sync with it.
	"gsettings set org.gnome.desktop.interface font-name 'SF Pro Text 11'",
	"gsettings set org.gnome.desktop.interface monospace-font-name 'BerkeleyMono Nerd Font Mono 11'",
	"gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'",
	"gsettings set org.gnome.desktop.interface font-hinting 'slight'",

	-- XWayland runs unscaled (force_zero_scaling); give Xft apps the right DPI
	-- (96 * 4/3 panel scale). No-op until xorg-xrdb is installed.
	"sh -c 'command -v xrdb >/dev/null && xrdb -merge ~/.Xresources'",

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
