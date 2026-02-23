-- local module_folder = "/home/marc/linux-config/scripts/"
-- package.path = module_folder .. "?.lua;" .. package.path
-- local util = require("util")
--
-- local CURRENT_WALLPAPER_PATH = "/home/marc/linux-config/current_wallpaper"

os.execute("lua /home/marc/linux-config/scripts/change-wallpaper.lua ordered")
-- util.sleep(2)
-- local lines = util.getFileLines(CURRENT_WALLPAPER_PATH)
-- if lines == nil or #lines == 0 then
-- 	return
-- end
--
-- local current_wallpaper_path = lines[1]
-- os.execute("matugen image " .. current_wallpaper_path)
--
-- os.execute("cp " .. current_wallpaper_path .. " /home/marc/linux-config/lockscreen/wallpaper.jpg")
-- os.execute("lua /home/marc/linux-config/scripts/nvim-server.lua")
