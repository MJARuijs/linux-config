local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local lines = util.getFileLines("/home/marc/.config/hypr/matugen.conf")
for _, line in pairs(lines) do
	local parts = line:split("=")
	print(line)
	local key = parts[1]
	local value = parts[2]
	print(util.os_command("hyprctl keyword " .. key .. " " .. value))
end
