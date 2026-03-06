local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local nvim_instances_string = util.os_command("ls /run/user/1000/nvim*")
local nvim_instances = nvim_instances_string:split("\n")

local command = '--remote-send "<cmd>colorscheme intellij<CR>"'
for _, nvim_instance in pairs(nvim_instances) do
	os.execute("nvim --server " .. nvim_instance .. " " .. command)
end
