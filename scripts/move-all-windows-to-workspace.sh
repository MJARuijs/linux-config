#!/usr/bin/env bash

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

#echo $current_workspace

target_workspace=$(((($1 - 1) * $monitor_count) + $current_workspace % $monitor_count))
#echo $target_workspace

#new_monitor=$(($current_monitor + $workspace_offset * $monitor_count))

window_addresses=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_workspace) | .address")
for address in $window_addresses; do
  hyprctl dispatch movetoworkspacesilent "$target_workspace"
done
echo $target_workspace
#hyprctl dispatch workspace "$new_monitor"
