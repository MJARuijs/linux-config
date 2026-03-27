local module_folder = "/home/marc/linux-config/scripts/"
package.path = module_folder .. "?.lua;" .. package.path
local util = require("util")

local MATUGEN_CONFIG_PATH = "/home/marc/.config/matugen/config.toml"

local M = {}

local function parseLine(line)
	local parts = line:split("=")
	if #parts == 2 then
		local value = parts[2]:trim()

		return value
	end
	return nil
end

function M.getWallpaperColors(wallpaper)
	local current_colors = util.os_command("matugen image --dry-run --show-colors --source-color-index 0 " .. wallpaper)

	local wallpaper_colors = {}

	local lines = current_colors:split("\n")
	for _, line in pairs(lines) do
		local parts = line:split("│")
		local color_name = parts[1]:trim()
		local hex_value = parts[4]:trim()
		if string.sub(hex_value, 1, 1):trim() == "#" then
			wallpaper_colors[color_name] = hex_value:gsub("#", "")
		end
	end

	return wallpaper_colors
end

function M.getTemplates()
	local matugen_config_file = util.getFileLines(MATUGEN_CONFIG_PATH)

	local matugen_templates = {}
	local current_template = {}

	for i = 1, #matugen_config_file do
		local line = matugen_config_file[i]:trim()
		if line:startsWith("#") then
			goto continue
		end

		print(line)

		if line:startsWith("[templates.") then
			local template_name = line:gsub("templates.", "")
			template_name = template_name:sub(2, #template_name - 1)
			print("Templatename: " .. template_name)
			current_template["template_name"] = template_name
		end

		if line:startsWith("input_path") then
			local input_value = parseLine(line)
			current_template["input_path"] = input_value:trim()
		end

		if line:startsWith("output_path") then
			local output_line = matugen_config_file[i]
			local output_value = parseLine(output_line)
			current_template["output_path"] = output_value:trim()

			if matugen_config_file[i + 1]:trim():startsWith("post_hook") == false then
				table.insert(matugen_templates, current_template)
				current_template = {}
			end
		end

		if line:startsWith("post_hook") then
			-- local post_hook_line = matugen_config_file[i + 1]
			local post_hook_value = parseLine(line)
			current_template["post_hook"] = post_hook_value:trim():gsub('"', ""):gsub("'", "")
			table.insert(matugen_templates, current_template)
			current_template = {}
		end

		::continue::
	end

	-- for i = 1, #matugen_config_file do
	-- 	local line = matugen_config_file[i]:trim()
	-- 	if line:startsWith("#") then
	-- 		goto continue
	-- 	end
	--
	-- 	-- if line:startsWith("[templates.") then
	-- 	-- 	local template_name = line:gsub("[templates.", ""):gsub("]", "")
	-- 	-- 	current_template["template_name"] = template_name
	-- 	-- end
	-- 	if line:startsWith("input_path") then
	-- 		local input_value = parseLine(line)
	-- 		current_template["input_path"] = input_value:trim()
	--
	-- 		if matugen_config_file[i + 1]:trim():startsWith("output_path") then
	-- 			local output_line = matugen_config_file[i + 1]
	-- 			local output_value = parseLine(output_line)
	-- 			current_template["output_path"] = output_value:trim()
	-- 			i = i + 1
	--
	-- 			if matugen_config_file[i + 1]:trim():startsWith("post_hook") then
	-- 				local post_hook_line = matugen_config_file[i + 1]
	-- 				local post_hook_value = parseLine(post_hook_line)
	-- 				current_template["post_hook"] = post_hook_value:trim():gsub('"', ""):gsub("'", "")
	-- 				i = i + 1
	-- 			end
	-- 			table.insert(matugen_templates, current_template)
	-- 			current_template = {}
	-- 		end
	-- 	end
	--
	-- 	::continue::
	-- end

	local templates = {}
	local post_hooks = {}

	for _, template in pairs(matugen_templates) do
		-- local template_name = template["template_name"]
		local input_path = template["input_path"]
		local output_path = template["output_path"]
		local post_hook = template["post_hook"]

		if input_path ~= nil and output_path ~= nil then
			if post_hook ~= nil and post_hook ~= "" then
				table.insert(post_hooks, post_hook)
			end

			local input_file_lines = util.getFileLines(input_path:gsub('"', ""):gsub("'", ""))

			table.insert(templates, { input_file_lines, output_path:gsub('"', ""):gsub("'", "") })
			-- matugen.applyColors(next_wallpaper_colors, input_file_lines, output_path:gsub('"', ""))
		end
	end
	return { templates, post_hooks }
end

function M.applyColors(colors, template, output_path)
	local output = ""

	for _, line in pairs(template) do
		local pattern = line:match("{{.*}}")
		if pattern == nil then
			output = output .. line .. "\n"
			goto continue
		end

		local pattern_value = pattern:sub(3, #pattern - 2)
		local color = colors[pattern_value]
		if color == nil then
			output = output .. line .. "\n"
			goto continue
		end

		-- output = output .. line:gsub(pattern, "hoi") .. "\n"
		output = output .. line:gsub(pattern, color) .. "\n"
		goto continue

		::continue::
	end

	util.write_to_file(output_path, output)
end

return M
