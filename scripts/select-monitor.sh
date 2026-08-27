#!/usr/bin/env bash
current_workspace=$(hyprctl activeworkspace -j | jq '.id')
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

if [ $monitor_count == 1 ]; then
    hyprctl dispatch "hl.dsp.focus({workspace=$1})"
    # hyprctl dispatch workspace "$1"
else
    current_monitor=$((($1 - 1 % $monitor_count) + 1))

    # echo $current_workspace
    # echo $monitor_count
    # echo $current_monitor

    workspace_offset=0

    for ((i = 1; i <= $monitor_count * 10; i++)); do
        var=$(($monitor_count * $i))
        if [ "$current_workspace" -le "$var" ]; then
            workspace_offset=$(($i - 1))
            break
        fi
    done

    new_workspace=$(($current_monitor + $workspace_offset * $monitor_count))
    new_monitor=$(hyprctl workspaces -j | jq -r ".[] | select(.id == $new_workspace) | .monitorID")

    echo $new_monitor
    echo $new_workspace
    # hyprctl dispatch "hl.dsp.focus({monitor ="
    # hyprctl dispatch focusmonitor "$new_monitor"
    # hyprctl dispatch workspace "$new_workspace"
fi
