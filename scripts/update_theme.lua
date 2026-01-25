local module_folder = "/home/marc/.config/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
util = require("util")

local log = ""

local function createLuaTable(lines, separator)
	local fileTable = {}

	for _, v in pairs(lines) do
		if #v == 0 then
			goto continue
		end

		local trimmedLine = v:trim()

		if not string.startsWith(trimmedLine, "--") then
			-- local splitValues = string.gmatch(trimmedLine, "([^" .. separator .. "]+)")
			local splitValues = trimmedLine:split(separator)
			local key = nil
			local value = nil

			local i = 1
			for splitValue in splitValues do
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

-- Source - https://stackoverflow.com/a
-- Posted by Yu Hao, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-01-24, License - CC BY-SA 3.0
local function sleep(n)
	os.execute("sleep " .. tonumber(n))
end

sleep(1)

local noctaliaColors = util.getFileLines("/home/marc/.config/noctalia/colors.json")
local nvimColors = util.getFileLines("/home/marc/.config/nvim/colorschemes/intellij.nvim/lua/intellij/my_palette.lua")

-- for c in nvimColors do
-- 	print(c)
-- 	log = log .. c .. "\n"
-- end

local nvimTable = createLuaTable(nvimColors, "=")
local noctaliaTable = createLuaTable(noctaliaColors, ":")

log = log .. "\n"
log = log .. "\n"

for k, v in pairs(nvimTable) do
	log = log .. "Key: " .. k .. ", value: " .. v .. "\n"
end

log = log .. "\n"
log = log .. "\n"
-- local index = 0
for k, _ in pairs(noctaliaTable) do
	if nvimTable[k] ~= nil then
		log = log .. "Setting to Nil: " .. k .. "\n"
		-- nvimTable[k] = nil
	end
	-- index = index + 1
end
local file_content = "return {\n"
local noctalia_content = ""
for k, v in pairs(noctaliaTable) do
	noctalia_content = noctalia_content .. "\t" .. k .. " = " .. v .. ",\n"
end
-- file_content = file_content .. "\n"
local nvim_content = ""
for k, v in pairs(nvimTable) do
	nvim_content = nvim_content .. "\t" .. k .. " = " .. v .. ",\n"
end

file_content = file_content .. noctalia_content .. "\n" .. nvim_content .. "}"

util.write_to_file("/home/marc/.config/nvim/colorschemes/intellij.nvim/lua/intellij/palette.lua", file_content)
util.write_to_file("/home/marc/noctalua.txt", noctalia_content)
util.write_to_file("/home/marc/nvim.txt", nvim_content)
util.write_to_file("/home/marc/log.txt", log)

os.execute("lua /home/marc/.config/linux-config/scripts/nvim-server.lua")
