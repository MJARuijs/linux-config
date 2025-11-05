#!/usr/bin/env bash

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

#echo $current_workspace

target_workspace=$(((($1 - 1) * 5) + $current_workspace % $monitor_count))
#echo $target_workspace

hyprctl dispatch movetoworkspacesilent "$target_workspace"

