local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local M = {}

local CURRENT_WALLPAPER_PATH = "/home/marc/linux-config/current_wallpaper_path"
local wallpaper_dir = "/home/marc/linux-config/wallpapers/"

function M.getWallpapersInDir()
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
	local wallpaper = initializeFirstWallpaper()

	if wallpaper == nil then
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

	file:write(wallpaper)
	file:close()

	return wallpaper
end

function M.getCurrentWallpaper()
	local lines = util.getFileLines(CURRENT_WALLPAPER_PATH)
	if lines == nil or #lines == 0 then
		return createCurrentWallpaperFile()
	end

	return lines[1]
end

function M.saveCurrentWallpaper(wallpaper)
	local file = io.open(CURRENT_WALLPAPER_PATH, "w")
	if file == nil then
		os.execute("notify-send FAILED TO SAVE WALLPAPER!")
		print("FAILED TO SAVE WALLPAPER")
		return nil
	end
	file:write(wallpaper)
	file:close()
end

return M
