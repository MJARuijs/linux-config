local module_folder = "/home/marc/linux-config/scripts/wallpaper-automation/?.lua;/home/marc/linux-config/scripts/?.lua;"
package.path = module_folder .. package.path

local util = require("util")
local wallpaper_loader = require("current-wallpaper-loader")
local matugen = require("matugen")

local AWWW_COMMAND = "/home/marc/Software/awww/target/release/awww"
local HA_COMMAND = "/home/marc/linux-config/scripts/ha-update-entity.lua"

-- local function updateLEDStrips(primary_color)
-- local desk_color_hsv = util.os_command("pastel format hsl " .. primary_color):gsub("\\%", ""):split(",")
-- print("OG pastel format rgb " .. desk_color_hsv[1] .. "," .. desk_color_hsv[2] .. "," .. desk_color_hsv[3])
-- desk_color_hsv[1] = desk_color_hsv[1]:sub(5):trim()
-- desk_color_hsv[2] = 100
-- desk_color_hsv[3] = desk_color_hsv[3]:sub(1, #desk_color_hsv[3] - 3):trim() / 2
--
-- -- print("pastel format rgb " .. desk_color_hsv[1] .. "," .. desk_color_hsv[2] .. "," .. desk_color_hsv[3])
-- local desk_color_rgb = util.os_command("pastel format rgb 'hsl(" .. desk_color_hsv[1] .. "," .. desk_color_hsv[2] .. "%," .. desk_color_hsv[3] .. "%)'")
-- desk_color_rgb = desk_color_rgb:sub(5, #desk_color_rgb - 2):gsub(" ", "")
-- print(desk_color_rgb)

local monitors_color_rgb = util.os_command("pastel format rgb 'rgb(0, 255 ,0)'")
monitors_color_rgb = monitors_color_rgb:sub(5, #monitors_color_rgb - 2):gsub(" ", "")

print(monitors_color_rgb)
-- os.execute(
-- 	"lua " .. HA_COMMAND .. ' light turn_on entity_id \\"light.led_strip_controller_desk_led_strip\\" rgb_color [' .. desk_color_rgb .. "] transition 2"
-- )
os.execute(
	"lua " .. HA_COMMAND .. ' light turn_on entity_id \\"light.led_strip_controller_monitors_led_strip\\" rgb_color [' .. monitors_color_rgb .. "] transition 2"
)
-- end
