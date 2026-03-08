local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local lines = util.getFileLines("colors.css")

local new_lines = ""

for _, line in pairs(lines) do
	print(line)
	if line:startsWith("*") then
		goto continue
	end
	local parts = line:split(" ")
	if parts == nil or #parts < 3 then
		goto continue
	end

	if parts[3]:startsWith("#") == false then
		new_lines = new_lines .. line .. "\n"
		goto continue
	end

	local new_line = parts[1] .. " " .. parts[2] .. " #{{" .. parts[2] .. "}};\n"
	new_lines = new_lines .. new_line

	goto continue
	::continue::
end

util.write_to_file("template.css", new_lines)
