#!/usr/bin/env bash

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

# echo $current_workspace

if [ $monitor_count == 1 ]; then
    hyprctl dispatch "hl.dsp.window.move({workspace = $1, follow = false})"
    # hyprctl dispatch movetoworkspacesilent "$1"
else
    target_workspace=$(((($1 - 1) * $monitor_count) + (($current_workspace - 1) % $monitor_count + 1)))
    # echo $target_workspace

    hyprctl dispatch "hl.dsp.window.move({workspace = $target_workspace, follow = false})"
    # hyprctl dispatch movetoworkspacesilent "$target_workspace"
fi
