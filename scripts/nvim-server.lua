local module_folder = "/home/marc/.config/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
util = require("util")

local nvim_instances_string = util.os_command("ls /run/user/1000/nvim*")
nvim_instances = nvim_instances_string:split("\n")

local command = ""
for i = 1, #arg do
	-- command = command .. " " .. arg[i]
end
command = '--remote-send ":colorscheme intellij<CR>"'
for nvim_instance in nvim_instances do
	print("Running command: " .. "nvim --server " .. nvim_instance .. " " .. command)
	os.execute("nvim --server " .. nvim_instance .. " " .. command)
end
