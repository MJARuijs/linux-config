#!/usr/bin/env bash
current_workspace=$(hyprctl activeworkspace -j | jq '.id')
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

current_monitor=$((($1 - 1 % $monitor_count) + 1))

#echo $current_workspace
#echo $monitor_count
#echo $current_monitor

workspace_offset=0

for ((i = 1; i <= $monitor_count * 10; i++)); do
  var=$(($monitor_count * $i))
  if [ "$current_workspace" -le "$var" ]; then
    workspace_offset=$(($i - 1))
    break
  fi
done

new_monitor=$(($current_monitor + $workspace_offset * $monitor_count))

hyprctl dispatch workspace "$new_monitor"
