local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local file_lines = util.getFileLines("/home/marc/linux-config/.config/hypr/workspaces.lua")

for k, line in ipairs(file_lines) do
	local values = {}
	for word in string.gmatch(line, '"[%a%d-]+"') do
		local result, count = string.gsub(word, '"', "")
		table.insert(values, result)
		-- print(result)
	end
	print("Running: " .. 'hyprctl dispatch "hl.dsp.workspace.move({' .. values[1] .. ", monitor = '" .. values[2] .. "'})\"")
	os.execute('hyprctl dispatch "hl.dsp.workspace.move({workspace=' .. values[1] .. ", monitor = '" .. values[2] .. "'})\"")
	-- local workspaceStart = string.gmatch(line, '')
	-- print(line)
	-- for match in workspaceStart do
	-- 	print(match)
	-- end

	-- local parts = line:split("=")
	-- local workspaceId = parts[2]
	-- local monitorName = parts[3]
	-- print(workspaceId .. ", " .. monitorName)
end
