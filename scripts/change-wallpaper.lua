local module_folder = "/home/marc/linux-config/scripts/wallpaper-automation/?.lua;/home/marc/linux-config/scripts/?.lua;"
package.path = module_folder .. package.path

local util = require("util")
local wallpaper_loader = require("current-wallpaper-loader")
local matugen = require("matugen")

local AWWW_COMMAND = "/home/marc/Software/awww/target/release/awww"
local HA_COMMAND = "/home/marc/linux-config/scripts/ha-update-entity.lua"

local wallpaper_dir = "/home/marc/linux-config/wallpapers/"

local function determineTransitionEffect()
	local arguments = { " --transition-fps 100" }

	local transition_types = { "simple", "wave", "wipe", "grow", "outer" }

	local random = math.random(1, #transition_types)
	local transition_type = transition_types[random]

	local transition_duration = "2.5"
	-- if transition_type == "simple" then
	-- 	transition_duration = "10"
	-- end

	table.insert(arguments, " --transition-bezier .49,.19,.52,.92")
	table.insert(arguments, math.random(0, 359))
	if transition_type == "wave" then
		table.insert(arguments, " --transition-wave ")
		table.insert(arguments, " 60,20 ")
	end
	table.insert(arguments, " --transition-duration ")
	table.insert(arguments, transition_duration)

	table.insert(arguments, " --transition-type ")
	table.insert(arguments, transition_type)

	return arguments
end

-- Fullscreen applications mess up changing of the wallpaper.
-- This method finds monitors that are displaying fullscreen windows, and puts them last in the argument list
-- This way any monitor that isn't showing a fullscreen window gets updated correctly.
local function constructMonitorArgument()
	local monitor_workspaces = util.os_command('hyprctl monitors -j | jq -r ".[] | .name, .activeWorkspace.id"'):split("\n")

	local regular_monitors_argument = ""
	local fullscreen_monitor_argument = ""

	for i = 1, #monitor_workspaces, 2 do
		local monitor_name = monitor_workspaces[i]
		local workspace_id = monitor_workspaces[i + 1]

		if workspace_id ~= nil then
			local fullscreen_window =
				util.os_command('hyprctl clients -j | jq -r ".[] | select(.workspace.id == ' .. workspace_id .. ' and .fullscreen == 2) | .monitor"')

			if fullscreen_window == nil or fullscreen_window == "" then
				regular_monitors_argument = regular_monitors_argument .. monitor_name .. ","
			else
				fullscreen_monitor_argument = fullscreen_monitor_argument .. monitor_name .. ","
			end
		end
	end

	return { regular_monitors_argument, fullscreen_monitor_argument }
end

local function determineNextWallpaper()
	local wallpapers = wallpaper_loader.getWallpapersInDir()
	local wallpaper = ""
	if arg[1] == "random" then
		local numberOfWallpapers = #wallpapers
		if numberOfWallpapers == 0 then
			print("No wallpapers found at " .. wallpaper_dir .. "!")
			return
		end

		local random = math.random(1, numberOfWallpapers)
		wallpaper = wallpapers[random]
	elseif arg[1] == "ordered" then
		local current_wallpaper_path = wallpaper_loader.getCurrentWallpaper()
		if current_wallpaper_path == nil then
			return
		end

		local dirs = current_wallpaper_path:split("/")
		local current_wallpaper = dirs[#dirs]:trim()
		local current_wallpaper_index = -1

		for i, v in pairs(wallpapers) do
			if current_wallpaper == v then
				current_wallpaper_index = i
			end
		end

		local next_wallpaper_index = -1
		if current_wallpaper_index == #wallpapers then
			next_wallpaper_index = 1
		else
			next_wallpaper_index = current_wallpaper_index + 1
		end
		wallpaper = wallpapers[next_wallpaper_index]
	else
		wallpaper = arg[1]
	end

	if wallpaper:startsWith("/home/marc") == false and wallpaper:startsWith("~/") == false then
		wallpaper = wallpaper_dir .. wallpaper
	end

	return wallpaper
end

local function updateColorscheme(parameters)
	local current_wallpaper_path = parameters[1]
	os.execute("matugen image " .. current_wallpaper_path)
	os.execute("cp " .. current_wallpaper_path .. " /home/marc/linux-config/current_wallpaper")
end

local function updateLEDStrips(primary_color, transition_duration)
	local desk_color_hsv = util.os_command("pastel format hsl " .. primary_color):gsub("\\%", ""):split(",")
	-- print("OG pastel format rgb " .. desk_color_hsv[1] .. "," .. desk_color_hsv[2] .. "," .. desk_color_hsv[3])
	desk_color_hsv[1] = desk_color_hsv[1]:sub(5):trim()
	desk_color_hsv[2] = 100
	desk_color_hsv[3] = desk_color_hsv[3]:sub(1, #desk_color_hsv[3] - 3):trim() / 2

	-- print("pastel format rgb " .. desk_color_hsv[1] .. "," .. desk_color_hsv[2] .. "," .. desk_color_hsv[3])
	local desk_color_rgb = util.os_command("pastel format rgb 'hsl(" .. desk_color_hsv[1] .. "," .. desk_color_hsv[2] .. "%," .. desk_color_hsv[3] .. "%)'")
	desk_color_rgb = desk_color_rgb:sub(5, #desk_color_rgb - 2):gsub(" ", "")
	print(desk_color_rgb)

	local monitors_color_rgb = util.os_command("pastel complement 'rgb(" .. desk_color_rgb .. ")' | pastel format rgb")
	monitors_color_rgb = monitors_color_rgb:sub(5, #monitors_color_rgb - 2):gsub(" ", "")

	print(monitors_color_rgb)
	os.execute(
		"lua "
			.. HA_COMMAND
			.. ' light turn_on entity_id \\"light.led_strip_controller_desk_led_strip\\" rgb_color ['
			.. desk_color_rgb
			.. "] transition "
			.. transition_duration
	)
	os.execute(
		"lua "
			.. HA_COMMAND
			.. ' light turn_on entity_id \\"light.led_strip_controller_monitors_led_strip\\" rgb_color ['
			.. monitors_color_rgb
			.. "] transition "
			.. transition_duration
	)
end

local current_wallpaper = wallpaper_loader.getCurrentWallpaper()
local current_wallpaper_colors = matugen.getWallpaperColors(current_wallpaper)

local next_wallpaper = determineNextWallpaper()
local next_wallpaper_colors = matugen.getWallpaperColors(next_wallpaper)

local matugen_templates = matugen.getTemplates()
local templates = matugen_templates[1]
local post_hooks = matugen_templates[2]

local transition_effect = determineTransitionEffect()
local command = AWWW_COMMAND .. " img " .. next_wallpaper

for _, arg in pairs(transition_effect) do
	command = command .. arg
end

local monitor_types = constructMonitorArgument()

for _, monitors in pairs(monitor_types) do
	if #monitors ~= 0 then
		os.execute(command .. " -o " .. monitors)
	end
end
-- os.e

local parameters = transition_effect[#transition_effect]

-- for _, v in pairs(templates) do
-- 	matugen.applyColors(next_wallpaper_colors, v[1], v[2])
-- end

-- local post_hooks = {}
--
-- for _, template in pairs(matugen_templates) do
-- 	local input_path = template["input_path"]
-- 	local output_path = template["output_path"]
-- 	local post_hook = template["post_hook"]
--
-- 	if input_path ~= nil and output_path ~= nil then
-- 		if post_hook ~= nil and post_hook ~= "" then
-- 			table.insert(post_hooks, post_hook:gsub('"', ""))
-- 		end
--
-- 		local input_file_lines = util.getFileLines(input_path:gsub('"', ""))
--
-- 		matugen.applyColors(next_wallpaper_colors, input_file_lines, output_path:gsub('"', ""))
-- 	end
-- end

-- if parameters == nil then
-- 	return
-- end
-- if parameters[2] == "simple" then
-- 	util.sleep(0.8)
-- elseif parameters[2] == "wave" then
-- 	util.sleep(1.4)
-- elseif parameters[2] == "wipe" then
-- 	util.sleep(1.1)
-- elseif parameters[2] == "grow" then
-- 	util.sleep(1.0)
-- elseif parameters[2] == "outer" then
-- 	util.sleep(1.1)
-- end
--
-- updateColorscheme(parameters)

local timer = util.createTimer(2, 0.01, function(progress)
	local intermediate_colors = {}
	for color_name, current_color in pairs(current_wallpaper_colors) do
		local next_wallpaper_color = next_wallpaper_colors[color_name]
		if next_wallpaper_color == nil then
			goto continue
		end

		local mix = util
			.os_command("pastel mix " .. next_wallpaper_color:gsub("#", "") .. " " .. current_color:gsub("#", "") .. " -f " .. progress / 2.0 .. " | pastel format hex")
			:trim()
			:gsub("#", "")

		intermediate_colors[color_name] = mix
		goto continue
		::continue::
	end

	for i, template in pairs(templates) do
		matugen.applyColors(intermediate_colors, template[1], template[2])
		local post_hook = post_hooks[i]
		if post_hook ~= nil and post_hook ~= "" then
			os.execute(post_hook)
		end
	end
end)

updateLEDStrips(next_wallpaper_colors["primary"], 2)
-- updateLEDStrips("", "")

while timer.isRunning() do
end

wallpaper_loader.saveCurrentWallpaper(next_wallpaper)

-- local next_primary_color = next_wallpaper_colors["primary"]
-- updateLEDStrips(next_primary_color)

for i, template in pairs(templates) do
	matugen.applyColors(next_wallpaper_colors, template[1], template[2])
	local post_hook = post_hooks[i]
	if post_hook ~= nil and post_hook ~= "" then
		os.execute(post_hook)
	end
end
-- os.execute("hyprctl keyword general:col.active_border 0xff" .. second)
-- for _, hook in pairs(post_hooks) do
-- 	os.execute(hook)
-- end
