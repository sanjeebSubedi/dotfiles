-- Hyprland Lua entrypoint.

local source = debug.getinfo(1, "S").source
local hypr_dir

if source:sub(1, 1) == "@" then
	hypr_dir = source:sub(2):match("(.*/)")
end

if not hypr_dir then
	local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
	if xdg_config_home and xdg_config_home ~= "" then
		hypr_dir = xdg_config_home .. "/hypr/"
	else
		hypr_dir = (os.getenv("HOME") or "~") .. "/.config/hypr/"
	end
end

package.path = table.concat({
	hypr_dir .. "?.lua",
	hypr_dir .. "?/init.lua",
	package.path,
}, ";")

local modules = {
	"hyprland.env",
	"hyprland.monitors",
	"hyprland.programs",
	"hyprland.autostart",
	"hyprland.appearance",
	"hyprland.input",
	"hyprland.keybinds",
	"hyprland.rules",
}

for _, module in ipairs(modules) do
	package.loaded[module] = nil
end

require("hyprland.env")
require("hyprland.monitors")

local programs = require("hyprland.programs")

require("hyprland.autostart").setup()
require("hyprland.appearance")
require("hyprland.input")
require("hyprland.keybinds").setup(programs)
require("hyprland.rules")
