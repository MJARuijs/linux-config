local M = {}

-- Source - https://stackoverflow.com/a
-- Posted by Yu Hao, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-01-24, License - CC BY-SA 3.0
function M.sleep(n)
	os.execute("sleep " .. tonumber(n))
end

function M.os_command(command)
	local handle = io.popen(command)
	-- print("EXECUTING OS COMMAND: " .. command)
	if handle == nil then
		return nil
	end

	local result = handle:read("*a")
	handle:close()
	return result
end

-- Source - https://stackoverflow.com/a/11130774
-- Posted by Bobby Oster, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-02-20, License - CC BY-SA 3.0

-- Lua implementation of PHP scandir function
function M.scandir(directory)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen('ls -a "' .. directory .. '"')

	if pfile == nil then
		return nil
	end
	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end
	pfile:close()
	return t
end

function string.trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function string.startsWith(s, start)
	return string.sub(s, 1, string.len(start)) == start
end

function string.split(s, separator)
	local iterator = string.gmatch(s, "([^" .. separator .. "]+)")
	local results = {}
	for value in iterator do
		table.insert(results, value)
	end
	return results
end

function M.write_to_file(file_name, content)
	local nvimColorFiles = io.open(file_name, "w+")

	if nvimColorFiles == nil then
		print("COULDN'T WRITE TO FILE: " .. file_name)
		return
	end

	nvimColorFiles:write(content)
	nvimColorFiles:close()
end

function M.getFileLines(filePath)
	local file = io.open(filePath, "r+")

	if file == nil then
		return {}
	end

	local content = file:read("*a")
	local lines = {}
	local file_lines = content:split("\n")

	for _, line in pairs(file_lines) do
		if line ~= nil then
			table.insert(lines, line)
		end
	end

	return lines
end

return M
