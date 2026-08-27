local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local FILE_PATH = "/home/marc/Documents/inOne/Development/heidi/ngmyinone/tsconfig.json"

local file_lines = util.getFileLines(FILE_PATH)

local has_compiler_options = false

for _, line in pairs(file_lines) do
	if line:trim():startsWith('"angularCompilerOptions"') then
		has_compiler_options = true
	end
end

if has_compiler_options == false then
	local last_line = table.remove(file_lines, #file_lines)

	local file_content = ""
	for _, line in pairs(file_lines) do
		file_content = file_content .. line .. "\n"
	end
	file_content = file_content .. '  "angularCompilerOptions": {\n' .. '    "strictTemplates": true\n' .. "  }\n" .. last_line

	util.write_to_file(FILE_PATH, file_content)
end
