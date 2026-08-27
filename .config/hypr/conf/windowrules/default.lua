hl.window_rule({
	match = {
		title = "^(Brave-browser)$",
	},
	tile = true,
})
hl.window_rule({
	match = {
		title = "^(Chromium)$",
	},
	tile = true,
})
hl.window_rule({
	match = {
		title = "^(pavucontrol)$",
	},
	float = true,
})
hl.window_rule({
	match = {
		title = "^(blueman-manager)$",
	},
	float = true,
})
hl.window_rule({
	match = {
		title = "^(nm-connection-editor)$",
	},
	float = true,
})
hl.window_rule({
	match = {
		title = "^(qalculate-gtk)$",
	},
	float = true,
})
hl.window_rule({
	match = {
		class = "^(mpv)$",
	},
	opacity = "1",
})
hl.window_rule({
	match = {
		fullscreen_state_client = 2,
	},
	opacity = "1",
})
