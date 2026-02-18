local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local function isMonitorActive(monitorId)
	local activeMonitorId = util.os_command("hyprctl activeworkspace -j | jq '.monitorID'"):trim()
	print(activeMonitorId .. " :: " .. monitorId)
	return monitorId == activeMonitorId
end

local function isClientActive(className)
	local window = util.os_command("hyprctl clients -j | jq -r '.[] | select(.class == \"org.gnome.Nautilus\") | .address'"):trim()

	return window ~= nil and window ~= ""
end

local function startProgram(programToRun)
	local programMonitorAssignments = util.getFileLines("/home/marc/linux-config/program-monitor-assignment.txt")

	for _, line in pairs(programMonitorAssignments) do
		local lineValues = line:split("|")
		local programName = lineValues[1]
		local monitorId = lineValues[2]

		print("Name: " .. programName .. ". Monitor: " .. monitorId)
		if programName == programToRun then
			print("EXECUTING")
			-- util.os_command("hyprctl dispatch focusmonitor " .. monitorId)
			-- while not isMonitorActive(monitorId) do
			-- end

			util.os_command("exec nohup " .. programName .. " & exit")
			-- util.os_command(programName)

			local window = util.os_command("hyprctl clients -j | jq -r '.[] | select(.class == \"org.gnome.Nautilus\") | .address'"):trim()
			while window == nil or window == "" do
				window = util.os_command("hyprctl clients -j | jq -r '.[] | select(.class == \"org.gnome.Nautilus\") | .address'"):trim()
			end
			print("WINDOW: " .. window)
			util.os_command("hyprctl dispatch movetoworkspace " .. monitorId .. ",address:" .. window)
		end
	end
end

local activeWindowsString = util.os_command("hyprctl clients -j | jq -r '.[] | select(.class == \"" .. arg[1] .. "\") | .workspace.id'")
local activeWindows = activeWindowsString:split("\n")
if #activeWindows == 0 then
	startProgram(arg[1])
else
	for _, v in pairs(activeWindows) do
		print(v)
	end
end
