#!/usr/bin/env bash
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
target_workspace=$((($1 - 1) * $monitor_count))

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
# current_monitor=$(hyprctl activemonitor)
current_monitor=$((($current_workspace - 1) % $monitor_count))
echo $current_monitor

current_cursor_position=$(hyprctl cursorpos)
parsed_current_cursor_position=${current_cursor_position//,/ }
echo $parsed_current_cursor_position

for ((i = $monitor_count; i > 0; i--)); do
  echo 'Switching to ' $(($target_workspace + $i))
  hyprctl dispatch workspace "$(($target_workspace + $i))"
done
# $(hyprctl focusmonitor $current_monitor)
# $(hyprctl dispatch movecursor $parsed_current_cursor_position)

# for ((i = 1; i <= $monitor_count * 10; i++)); do
#   var=$(($monitor_count * $i))
#   if [ "$current_workspace" -le "$var" ]; then
#     workspace_offset=$(($i - 1))
#     break
#   fi
# done
#
# new_monitor=$(($current_monitor + $workspace_offset * $monitor_count))
# echo $new_monitor
