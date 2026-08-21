hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd("walker"))

hl.bind("SUPER + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("lua /home/marc/linux-config/scripts/assign-workspaces.lua"))

hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("sh /home/marc/linux-config/scripts/logout.sh"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("sh /home/marc/.config/ml4w/settings/terminal.sh"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("sh /home/marc/.config/ml4w/settings/browser.sh"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("firefox -- private-window"))

hl.bind("SUPER + E", hl.dsp.exec_cmd("/home/marc/.config/ml4w/settings/filemanager.sh"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("lua /home/marc/linux-config/scripts/launch-workspacebound-program.lua dbeaver"))

hl.bind("SUPER + N", hl.dsp.exec_cmd("sh /home/marc/linux-config/scripts/launch_neovide.sh"))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())
-- hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill "))

-- hl.bind("SUPER + W", hl.dsp.exec_cmd("lua /home/marc/linux-config/scripts/change-wallpaper.lua ordered"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
-- hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("sh /home/marc/.config/hypr/scripts/launcher.sh"))
hl.bind("SUPER + CTRL + P", hl.dsp.exec_cmd("sh /home/marc/.config/hypr/scripts/keybindings.sh"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("sh /home/marc/.config/ml4w/scripts/cliphist.sh"))
hl.bind("SUPER + CTRL + SHIFT + X", hl.dsp.exec_cmd("cliphist wipe"))

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(
	"SUPER + F",
	hl.dsp.window.fullscreen({
		mode = "fullscreen",
		action = "toggle",
	})
)

hl.bind("SUPER + ALT + T", hl.dsp.window.float())

hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }))

hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "r" }))

hl.bind("SUPER + CTRL + b", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + CTRL + h", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + CTRL + j", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER + CTRL + k", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + CTRL + l", hl.dsp.window.swap({ direction = "r" }))

hl.bind("ALT + SHIFT + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind("ALT + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind("ALT + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind("ALT + SHIFT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })

hl.bind("CTRL + 1", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 1"))
hl.bind("CTRL + 2", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 2"))
hl.bind("CTRL + 3", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 3"))
hl.bind("CTRL + 4", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 4"))
hl.bind("CTRL + 5", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 5"))
hl.bind("CTRL + 6", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 6"))
hl.bind("CTRL + 7", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 7"))
hl.bind("CTRL + 8", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 8"))
hl.bind("CTRL + 9", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 9"))
hl.bind("CTRL + 0", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-workspace.sh 10"))

hl.bind("CTRL + SHIFT + 1", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 1"))
hl.bind("CTRL + SHIFT + 2", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 2"))
hl.bind("CTRL + SHIFT + 3", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 3"))
hl.bind("CTRL + SHIFT + 4", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 4"))
hl.bind("CTRL + SHIFT + 5", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 5"))
hl.bind("CTRL + SHIFT + 6", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 6"))
hl.bind("CTRL + SHIFT + 7", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 7"))
hl.bind("CTRL + SHIFT + 8", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 8"))
hl.bind("CTRL + SHIFT + 9", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 9"))
hl.bind("CTRL + SHIFT + 0", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-workspace.sh 10"))

hl.bind("SUPER + CTRL + 1", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 1"))
hl.bind("SUPER + CTRL + 2", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 2"))
hl.bind("SUPER + CTRL + 3", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 3"))
hl.bind("SUPER + CTRL + 4", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 4"))
hl.bind("SUPER + CTRL + 5", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 5"))
hl.bind("SUPER + CTRL + 6", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 6"))
hl.bind("SUPER + CTRL + 7", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 7"))
hl.bind("SUPER + CTRL + 8", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 8"))
hl.bind("SUPER + CTRL + 9", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 9"))
hl.bind("SUPER + CTRL + 0", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-all-windows-to-workspace.sh 10"))

hl.bind("SUPER + 1", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 1"))
hl.bind("SUPER + 2", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 2"))
hl.bind("SUPER + 3", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 3"))
hl.bind("SUPER + 4", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 4"))
hl.bind("SUPER + 5", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 5"))
hl.bind("SUPER + 6", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 6"))
hl.bind("SUPER + 7", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 7"))
hl.bind("SUPER + 8", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 8"))
hl.bind("SUPER + 9", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 9"))
hl.bind("SUPER + 0", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/select-monitor.sh 10"))

hl.bind("SUPER + SHIFT + 1", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 1"))
hl.bind("SUPER + SHIFT + 2", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 2"))
hl.bind("SUPER + SHIFT + 3", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 3"))
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 4"))
hl.bind("SUPER + SHIFT + 5", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 5"))
hl.bind("SUPER + SHIFT + 6", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 6"))
hl.bind("SUPER + SHIFT + 7", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 7"))
hl.bind("SUPER + SHIFT + 8", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 8"))
hl.bind("SUPER + SHIFT + 9", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 9"))
hl.bind("SUPER + SHIFT + 0", hl.dsp.exec_cmd("/home/marc/linux-config/scripts/move-active-window-to-monitor.sh 10"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))

hl.bind("SUPER + W", hl.dsp.submap("wallpaper"))
hl.define_submap("wallpaper", function()
	hl.bind("W", function()
		hl.dispatch(hl.dsp.exec_cmd("lua /home/marc/linux-config/scripts/change-wallpaper.lua ordered"))
	end)

	hl.bind("G", function()
		hl.dispatch(hl.dsp.exec_cmd("lua /home/marc/linux-config/scripts/change-wallpaper.lua /home/marc/linux-config/wallpapers/green-leaves.jpg"))
	end)

	hl.bind("B", function()
		hl.dispatch(hl.dsp.exec_cmd("lua /home/marc/linux-config/scripts/change-wallpaper.lua /home/marc/linux-config/wallpapers/minimal-blue-mountains.jpg"))
	end)

	hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + C", hl.dsp.submap("configuration"))
hl.define_submap("configuration", function()
	hl.bind("h", function()
		hl.dispatch(hl.dsp.exec_cmd('neovide ~/.config/hypr/hyprland.lua --fork -- --cmd "tcd /home/marc/.config/hypr"'))
	end)

	hl.bind("k", function()
		hl.dispatch(hl.dsp.exec_cmd('neovide ~/.config/hypr/keybinds.lua --fork -- --cmd "tcd /home/marc/.config/hypr"'))
	end)

	hl.bind("a", function()
		hl.dispatch(hl.dsp.exec_cmd('neovide ~/.config/hypr/conf/autostart.lua --fork -- --cmd "tcd /home/marc/.config/hypr"'))
	end)

	hl.bind("m", function()
		hl.dispatch(hl.dsp.exec_cmd('neovide ~/.config/matugen/config.toml --fork -- --cmd "tcd /home/marc/.config/matugen"'))
	end)
	hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.bind("SUPER + CTRL + Z", hl.dsp.window.set_prop({ prop = "active_border_color", value = "rgb(FF0000)" }))

hl.bind("SUPER + SHIFT + G", function()
	local gapsInValueTable = hl.get_config("general.col.active_border")

	hl.notification.create({ text = "Gaps: " .. gapsInValueTable["colors"][1], timeout = 2000 })
	-- hl.notification.create({ text = "Gaps: " .. gapsInValueTable, timeout = 2000 })
	-- for k, v in pairs(gapsInValueTable) do
	-- 	hl.notification.create({ text = "Gaps: " .. k, timeout = 2000 })
	-- end
	-- if gapsInValueTable.top == 3 then
	-- 	hl.config({
	-- 		general = { gaps_in = 0 },
	-- 	})
	-- else
	-- 	hl.config({
	-- 		general = { gaps_in = 3 },
	-- 	})
	-- end
end)
