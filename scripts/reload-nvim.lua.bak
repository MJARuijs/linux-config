local util = require("util")

local pids = util.os_command("pidof nvim | jq")
if pids == nil then
	return
end
-- local pidList = string.gmatch(pids, "([^\n]+)")
local pidList = pids:split("\n")
for _, v in pairs(pidList) do
	print("kill -s SIGUSR1 " .. v:trim())
	os.execute("kill -s SIGUSR1 " .. v:trim())
end
