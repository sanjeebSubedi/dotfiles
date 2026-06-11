hl.window_rule({
	name = "no-border-single",
	match = {
		float = false,
		workspace = "w[tv1]",
	},
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "no-border-fullscreen",
	match = {
		float = false,
		workspace = "f[1]",
	},
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = {
		class = "hyprland-run",
	},
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "yazi-terminal-popup",
	match = {
		class = "^yazi-term$",
	},
	float = true,
	size = "monitor_w*0.8 monitor_h*0.8",
	rounding = 12,
	center = true,
})

hl.window_rule({
	name = "impala-network-popup",
	match = {
		class = "^impala-float$",
	},
	float = true,
	size = "monitor_w*0.4 monitor_h*0.6",
	rounding = 12,
	center = true,
})

hl.window_rule({
	name = "wiremix-audio-popup",
	match = {
		class = "^wiremix-float$",
	},
	float = true,
	size = "monitor_w*0.5 monitor_h*0.6",
	rounding = 12,
	center = true,
})

hl.window_rule({
	name = "bluetui-bluetooth-popup",
	match = {
		class = "^bluetui-float$",
	},
	float = true,
	size = "monitor_w*0.5 monitor_h*0.6",
	rounding = 12,
	center = true,
})

hl.window_rule({
	name = "calcurse-calendar-popup",
	match = {
		class = "^calcurse-float$",
	},
	float = true,
	size = "monitor_w*0.6 monitor_h*0.7",
	rounding = 12,
	center = true,
})

hl.layer_rule({
	name = "no-anim-launcher",
	match = {
		namespace = "launcher",
	},
	no_anim = true,
})

-- Frosted-glass wlogout: its window is translucent (style.css) and the
-- compositor blurs what's behind it.
hl.layer_rule({
	name = "blur-wlogout",
	match = {
		namespace = "logout_dialog",
	},
	blur = true,
	ignore_alpha = 0.2,
})
