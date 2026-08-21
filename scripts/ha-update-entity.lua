local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local ha_token = util.getFileLines("/home/marc/linux-config/ha_token")[1]

if ha_token ~= nil then
	local curl_command = 'curl -H "Authorization: Bearer ' .. ha_token .. '"'
	curl_command = curl_command .. ' -H "Content-Type: application/json"'

	if #arg ~= 0 then
		curl_command = curl_command .. " -d '{"
	end
	for i = 3, #arg, 2 do
		local parameter = arg[i]
		local value = arg[i + 1]
		curl_command = curl_command .. '"' .. parameter .. '":' .. value .. ""
		if #arg ~= i + 1 then
			curl_command = curl_command .. ","
		end
	end

	if #arg ~= 0 then
		curl_command = curl_command .. "}'"
	end

	curl_command = curl_command .. " http://192.168.178.215:8123/api/services/" .. arg[1] .. "/" .. arg[2]
	-- print(curl_command)
	os.execute(curl_command)
end
