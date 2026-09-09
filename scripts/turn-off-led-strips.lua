local HA_COMMAND = "/home/marc/linux-config/scripts/ha-update-entity.lua"
os.execute("lua " .. HA_COMMAND .. ' light turn_off entity_id \\"light.led_strip_controller_desk_led_strip\\"')
os.execute("lua " .. HA_COMMAND .. ' light turn_off entity_id \\"light.led_strip_controller_monitors_led_strip\\"')
