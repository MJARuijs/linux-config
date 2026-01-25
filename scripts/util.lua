local M = {}

function M.os_command(command)
	local handle = io.popen(command)
	if handle == nil then
		return nil
	end

	local result = handle:read("*a")
	handle:close()
	return result
end

function string.trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function string.startsWith(s, start)
	return string.sub(s, 1, string.len(start)) == start
end

function string.split(s, separator)
	return string.gmatch(s, "([^" .. separator .. "]+)")
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
	local file_log = "FileContent:\n"
	-- 	local lines = {}
	-- 	for line in io.lines(filePath) do
	-- 		lines[#lines + 1] = line
	-- 	end
	-- 	return lines
	local file = io.open(filePath, "r+")
	-- print(file:read("*a"))
	local content = file:read("*a")
	-- print(filePath .. " HALLO " .. content)
	local lines = {}
	local file_lines = content:split("\n")
	file_log = file_log .. content
	file_log = file_log .. "\n"
	file_log = file_log .. "\n"
	file_log = file_log .. "\n"
	for line in file_lines do
		if line ~= nil then
			-- print("FILELINE: " .. line)
			file_log = file_log .. line .. "\n"
			table.insert(lines, line)
		end
	end

	M.write_to_file("/home/marc/file_log.txt", file_log)
	return lines
end
return M
