local os_command = function(command)
	local handle = io.popen(command)
	if handle == nil then
		return nil
	end

	local result = handle:read("*a")
	handle:close()
	return result
end

local pids = os_command("pidof nvim | jq")
if pids == nil then
	return
end
local pidList = string.gmatch(pids, "([^\n]+)")
for v in pidList do
	print("kill -s SIGUSR1 " .. v)
	os_command("kill -s SIGUSR1 " .. v)
end
