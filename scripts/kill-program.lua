local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

util.os_command("ps axf | grep " .. arg[1] .. " | grep -v grep | awk '{print \"kill -9 \" $1}' | sh")
