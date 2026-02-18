require("util")

local pids = os_command("pidof nvim | jq")
if pids == nil then
	return
end
local pidList = string.gmatch(pids, "([^\n]+)")
for v in pidList do
	print("kill -s SIGUSR1 " .. v)
	os_command("kill -s SIGUSR1 " .. v)
end
