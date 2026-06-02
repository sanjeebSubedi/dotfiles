local M = {}

local main_mod = "SUPER"
local normal_gaps = {
    gaps_in = 5,
    gaps_out = 8,
}
local gaps_enabled = true

local function bind(keys, dispatcher, opts)
    return hl.bind(keys, dispatcher, opts)
end

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function toggle_layout()
    local current_layout = hl.get_config("general.layout")
    local next_layout = current_layout == "scrolling" and "dwindle" or "scrolling"

    hl.config({
        general = {
            layout = next_layout,
        },
    })
end

local function toggle_gaps()
    gaps_enabled = not gaps_enabled

    hl.config({
        general = {
            gaps_in = gaps_enabled and normal_gaps.gaps_in or 0,
            gaps_out = gaps_enabled and normal_gaps.gaps_out or 0,
        },
    })
end

local function setup_workspaces()
    for i = 1, 10 do
        local key = i % 10
        bind(main_mod .. " + " .. key, exec("~/.config/hypr/scripts/switch-workspace.sh " .. i))
        bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end
end

function M.setup(programs)
    -- Application launchers.
    bind(main_mod .. " + RETURN", exec(programs.terminal))
    bind(main_mod .. " + W", exec(programs.browser))
    bind(main_mod .. " + E", exec(programs.terminal .. " -e " .. programs.file_manager))
    bind(main_mod .. " + R", exec(programs.gui_file_manager))
    bind(main_mod .. " + SUPER_L", exec("pkill " .. programs.menu .. " || " .. programs.menu), { release = true })

    -- Window management.
    bind(main_mod .. " + Q", hl.dsp.window.close())
    bind(main_mod .. " + F", hl.dsp.window.float({ action = "toggle" }))
    bind(main_mod .. " + P", hl.dsp.window.pseudo())
    bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))
    bind(main_mod .. " + L", toggle_layout)
    bind(main_mod .. " + G", toggle_gaps)
    bind(main_mod .. " + M", hl.dsp.window.fullscreen(1))
    bind(main_mod .. " + H", hl.dsp.workspace.toggle_special("hidden"))
    bind(main_mod .. " + SHIFT + H", exec("~/.config/hypr/scripts/hide-window.sh"))

    -- Focus movement.
    bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
    bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
    bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
    bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

    -- Window movement.
    bind(main_mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
    bind(main_mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
    bind(main_mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
    bind(main_mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

    setup_workspaces()

    -- Mouse.
    bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
    bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Volume and brightness.
    bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
    bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
    bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
    bind("XF86MonBrightnessUp", exec("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
    bind("XF86MonBrightnessDown", exec("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

    -- Media.
    bind("XF86AudioNext", exec("playerctl next"), { locked = true })
    bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
    bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
    bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })

    -- Utilities.
    bind(main_mod .. " + V", exec("cliphist list | " .. programs.menu .. " --dmenu | cliphist decode | wl-copy"))
    bind(main_mod .. " + S", exec('grim -g "$(slurp)" - | wl-copy'))
    bind(main_mod .. " + SHIFT + S", exec('grim -g "$(slurp)" - | swappy -f -'))
    bind(main_mod .. " + Print", exec("grim ~/Pictures/Screenshots/Screenshot-$(date +'%s').png"))

    -- Screen recording.
    bind(main_mod .. " + SHIFT + R", exec("~/.config/hypr/scripts/screen-record.sh screen"))
    bind(main_mod .. " + ALT + R", exec("~/.config/hypr/scripts/screen-record.sh region"))
    bind(main_mod .. " + CTRL + R", exec("~/.config/hypr/scripts/screen-record.sh region-audio"))

    bind(main_mod .. " + BackSpace", exec("wlogout -b 5 -r 1 -c 5 -L 500 -R 500 -T 450 -B 450"))
    bind(main_mod .. " + SHIFT + C", exec("hyprpicker -a"))
end

return M
