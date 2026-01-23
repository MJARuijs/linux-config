#!/usr/bin/env bash
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
target_workspace=$((($1 - 1) * $monitor_count))

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
# current_monitor=$(hyprctl activemonitor)
current_monitor=$((($current_workspace - 1) % $monitor_count))
echo $current_monitor
current_cursor_position=$(hyprctl cursorpos)
parsed_current_cursor_position=${current_cursor_position//,/ }

for ((i = $monitor_count; i > 0; i--)); do
  echo 'Switching to ' $(($target_workspace + $i))
  hyprctl dispatch workspace "$(($target_workspace + $i))"
done
# $(hyprctl focusmonitor $current_monitor)
# $(hyprctl dispatch movecursor $parsed_current_cursor_position)
