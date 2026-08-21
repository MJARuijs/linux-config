hl.config({
	decoration = {
		rounding = 10,
		active_opacity = 0.8,
		inactive_opacity = 0.6,
		fullscreen_opacity = 1.0,
		blur = {
			enabled = true,
			size = 20,
			passes = 4,
			new_optimizations = true,
			ignore_opacity = true,
			xray = true,
		},
		shadow = {
			enabled = true,
			range = 30,
			render_power = 3,
			color = 0x66000000,
		},
	},
})
