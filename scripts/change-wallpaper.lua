local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local CURRENT_WALLPAPER_PATH = "/home/marc/linux-config/current_wallpaper_path"
local AWWW_COMMAND = "/home/marc/Software/awww/target/release/awww"

local TRANSITION_TYPE = "random"
local TRANSITION_DURATION = 4
local TRANSITION_FPS = 180

local wallpaper_dir = "/home/marc/linux-config/wallpapers/"
local wallpaper = arg[1]

local function getWallpapersInDir()
	local wallpapers = util.scandir(wallpaper_dir)

	if wallpapers == nil or #wallpapers == 0 then
		return {}
	end

	-- Remove first two elements, because ./ and ../ are also in the results-list
	table.remove(wallpapers, 1)
	table.remove(wallpapers, 1)
	return wallpapers
end

local function initializeFirstWallpaper()
	local wallpapers = util.scandir(wallpaper_dir)
	table.remove(wallpapers, 1)
	table.remove(wallpapers, 1)

	if wallpapers == nil or #wallpapers == 0 then
		os.execute("notify-send Tried to initialize first wallpaper, but couldn't find any at " .. wallpaper_dir)
		return nil
	end

	return wallpapers[1]
end

local function createCurrentWallpaperFile()
	local first_wallpaper = initializeFirstWallpaper()

	if first_wallpaper == nil then
		return nil
	end
	local file = io.open(CURRENT_WALLPAPER_PATH, "w")
	if file == nil then
		os.execute("notify-send FAILED TO INITIALIZE FIRST WALLPAPER!")
		print("FAILED TO INITIALIZE FIRST WALLPAPER")
		return nil
	end

	if wallpaper:startsWith("/home/marc") == false and wallpaper:startsWith("~/") == false then
		wallpaper = wallpaper_dir .. wallpaper
	end

	file:write(first_wallpaper)
	file:close()

	return first_wallpaper
end

local function getCurrentWallpaper()
	local lines = util.getFileLines(CURRENT_WALLPAPER_PATH)
	if lines == nil or #lines == 0 then
		return createCurrentWallpaperFile()
	end

	return lines[1]
end

local function saveCurrentWallpaper()
	local file = io.open(CURRENT_WALLPAPER_PATH, "w")
	if file == nil then
		os.execute("notify-send FAILED TO SAVE WALLPAPER!")
		print("FAILED TO SAVE WALLPAPER")
		return nil
	end
	file:write(wallpaper)
	file:close()
end

local function determineTransitionEffect()
	local arguments = { " --transition-fps 100" }

	local transition_types = { "simple", "wave", "wipe", "grow", "outer" }

	local random = math.random(1, #transition_types)
	local transition_type = transition_types[random]

	-- transition_type = "outer"

	local transition_duration = "2.5"
	if transition_type == "simple" then
		transition_duration = "10"
	end

	-- table.insert(arguments, " --transition-bezier .5,.5,.75,.75")
	table.insert(arguments, " --transition-bezier .49,.19,.52,.92")
	table.insert(arguments, math.random(0, 359))
	if transition_type == "wave" then
		table.insert(arguments, " --transition-wave ")
		table.insert(arguments, " 60,20 ")
	end
	table.insert(arguments, " --transition-duration ")
	table.insert(arguments, transition_duration)
	-- arguments:insert(transition_type)

	-- table.insert(arguments, " --transition-step 1")

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

local function changeWallpaper()
	local wallpapers = getWallpapersInDir()

	if arg[1] == "random" then
		local numberOfWallpapers = #wallpapers
		if numberOfWallpapers == 0 then
			print("No wallpapers found at " .. wallpaper_dir .. "!")
			return
		end

		local random = math.random(1, numberOfWallpapers)
		wallpaper = wallpapers[random]
	elseif arg[1] == "ordered" then
		local current_wallpaper_path = getCurrentWallpaper()
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

	saveCurrentWallpaper()

	local transition_effect = determineTransitionEffect()

	local command = AWWW_COMMAND .. " img " .. wallpaper

	for _, arg in pairs(transition_effect) do
		command = command .. arg
	end

	local monitor_types = constructMonitorArgument()

	for _, monitors in pairs(monitor_types) do
		os.execute(command .. " -o " .. monitors)
	end

	local parameters = { wallpaper, transition_effect[#transition_effect] }
	return parameters
end

local function updateColorscheme(parameters)
	local current_wallpaper_path = parameters[1]
	os.execute("matugen image " .. current_wallpaper_path)
	os.execute("cp " .. current_wallpaper_path .. " /home/marc/linux-config/current_wallpaper")
end

local parameters = changeWallpaper()
if parameters == nil then
	return
end
if parameters[2] == "simple" then
	util.sleep(0.8)
elseif parameters[2] == "wave" then
	util.sleep(1.4)
elseif parameters[2] == "wipe" then
	util.sleep(1.1)
elseif parameters[2] == "grow" then
	util.sleep(1.0)
elseif parameters[2] == "outer" then
	util.sleep(1.1)
end

updateColorscheme(parameters)
