local os_command = function(command)
	local handle = io.popen(command)
	if handle == nil then
		return nil
	end

	local result = handle:read("*a")
	handle:close()
	return result
end

local split_string = function(string)
	local lines = {}

	for s in string:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end
	return lines
end

local compare_monitors = function(a, b)
	if a[2] < b[2] then
		return true
	elseif a[2] == b[2] then
		if a[3] < b[3] then
			return true
		end
	end
	return false
end

Sort_monitors = function(monitors_to_sort, result)
	if #monitors_to_sort == 1 then
		table.insert(result, monitors_to_sort[1])
		return
	end

	table.sort(monitors_to_sort, compare_monitors)
	table.insert(result, monitors_to_sort[1])
	table.remove(monitors_to_sort, 1)
	Sort_monitors(monitors_to_sort, result)
end

local monitor_count = os_command("hyprctl monitors all | grep -o Monitor | wc -l")
local hyprctl_monitors = split_string(os_command("hyprctl monitors -j | jq -r '.[] | .name,.x,.y'"))
local workspace_count = 10

local monitors = {}

if monitor_count == nil or hyprctl_monitors == nil then
	return
end

for i = 1, 15, 3 do
	table.insert(monitors, { hyprctl_monitors[i], hyprctl_monitors[i + 1], hyprctl_monitors[i + 2] })
end

local sorted_monitors = {}
Sort_monitors(monitors, sorted_monitors)

local file_content = ""
local workspace_counter = 1

for i = 1, workspace_count do
	for j = 1, monitor_count do
		file_content = file_content .. "workspace=" .. workspace_counter .. ",monitor:" .. sorted_monitors[j][1]
		if i == 1 then
			file_content = file_content .. ",default:true"
		end
		workspace_counter = workspace_counter + 1
		file_content = file_content .. "\n"
	end
end

print(file_content)
local workspace_file = io.open("/home/marc/.config/hypr/workspaces.conf", "w+")
if workspace_file == nil then
	return
end
workspace_file:write(file_content)
workspace_file:close()
