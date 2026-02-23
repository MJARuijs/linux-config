local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local log = ""

local function createLuaTable(lines, separator)
	local fileTable = {}

	for _, v in pairs(lines) do
		if #v == 0 then
			goto continue
		end

		local trimmedLine = v:trim()

		if not string.startsWith(trimmedLine, "--") then
			local splitValues = trimmedLine:split(separator)
			local key = nil
			local value = nil

			local i = 1
			for _, splitValue in pairs(splitValues) do
				if i == 1 then
					key = splitValue:gsub('"', ""):trim()
				else
					value = splitValue:trim()
				end
				i = i + 1
			end

			if key ~= nil and value ~= nil then
				fileTable[key] = value:gsub(",", "")
			end
		end
		::continue::
	end

	return fileTable
end

local noctaliaColors = util.getFileLines("/home/marc/.config/noctalia/colors.json")
local nvimColors = util.getFileLines("/home/marc/.config/nvim/colorschemes/intellij.nvim/lua/intellij/my_palette.lua")

local nvimTable = createLuaTable(nvimColors, "=")
local noctaliaTable = createLuaTable(noctaliaColors, ":")

log = log .. "\n"
log = log .. "\n"

for k, v in pairs(nvimTable) do
	log = log .. "Key: " .. k .. ", value: " .. v .. "\n"
end

log = log .. "\n"
log = log .. "\n"

for k, _ in pairs(noctaliaTable) do
	if nvimTable[k] ~= nil then
		log = log .. "Setting to Nil: " .. k .. "\n"
	end
end

local file_content = "return {\n"
local noctalia_content = ""

for k, v in pairs(noctaliaTable) do
	noctalia_content = noctalia_content .. "\t" .. k .. " = " .. v .. ",\n"
end

local nvim_content = ""

for k, v in pairs(nvimTable) do
	nvim_content = nvim_content .. "\t" .. k .. " = " .. v .. ",\n"
end

file_content = file_content .. noctalia_content .. "\n" .. nvim_content .. "}"

util.write_to_file("/home/marc/.config/nvim/colorschemes/intellij.nvim/lua/intellij/palette.lua", file_content)
-- util.write_to_file("/home/marc/noctalua.txt", noctalia_content)
-- util.write_to_file("/home/marc/nvim.txt", nvim_content)
-- util.write_to_file("/home/marc/log.txt", log)

-- os.execute("lua /home/marc/linux-config/scripts/nvim-server.lua")
