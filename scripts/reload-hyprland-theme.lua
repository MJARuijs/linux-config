local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local lines = util.getFileLines("/home/marc/.config/hypr/matugen.conf")
for _, line in pairs(lines) do
	local parts = line:split("=")
	local key = parts[1]
	-- local value = "0000FF"
	local value = parts[2]
	-- os.execute("hyprctl --quiet keyword " .. key .. " " .. value)
	print("hyprctl eval 'hl.config({general = {col = {" .. key .. ' = {colors = {"rgb(' .. value .. ")\"}}}}})'")
	os.execute("hyprctl eval 'hl.config({general = {col = {" .. key .. ' = {colors = {"rgb(' .. value .. ")\"}}}}})'")
	-- os.execute("hyprctl dispatch 'hl.dsp.window.set_prop({prop=\"" .. key .. '", value="' .. value .. "\"})'")
end
