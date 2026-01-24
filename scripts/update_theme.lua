local function getFileLines(filePath)
	local lines = {}
	for line in io.lines(filePath) do
		lines[#lines + 1] = line
	end
	return lines
end

local function trimString(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function string.startsWith(s, start)
	return string.sub(s, 1, string.len(start)) == start
end

local function createLuaTable(lines, separator)
	local fileTable = {}
	for k, v in pairs(lines) do
		if #v == 0 then
			goto continue
		end
		local trimmedLine = trimString(v)
		if not string.startsWith(trimmedLine, "--") then
			local splitValues = string.gmatch(trimmedLine, "([^" .. separator .. "]+)")
			local key = nil
			local value = nil

			local i = 1
			for splitValue in splitValues do
				if i == 1 then
					key = trimString(splitValue:gsub('"', ""))
				else
					value = trimString(splitValue)
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
sleep(2)
local noctaliaColors = getFileLines("/home/marc/.config/noctalia/colors.json")
local nvimColors = getFileLines("/home/marc/.config/nvim/colorschemes/intellij.nvim/lua/intellij/palette.lua")

nvimTable = createLuaTable(nvimColors, "=")
noctaliaTable = createLuaTable(noctaliaColors, ":")

local index = 0
for k, v in pairs(noctaliaTable) do
	if nvimTable[k] ~= nil then
		nvimTable[k] = nil
	end
	index = index + 1
end
local file_content = "return {\n"

for k, v in pairs(noctaliaTable) do
	file_content = file_content .. "\t" .. k .. " = " .. v .. ",\n"
end
file_content = file_content .. "\n"
for k, v in pairs(nvimTable) do
	file_content = file_content .. "\t" .. k .. " = " .. v .. ",\n"
end

file_content = file_content .. "}"
local nvimColorFiles = io.open("/home/marc/.config/nvim/colorschemes/intellij.nvim/lua/intellij/palette.lua", "w+")
if nvimColorFiles == nil then
	return
end
nvimColorFiles:write(file_content)
nvimColorFiles:close()
-- os.execute("notify-send Updated Neovim-theme ")
