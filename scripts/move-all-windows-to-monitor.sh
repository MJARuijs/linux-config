#!/usr/bin/env bash
current_workspace=$(hyprctl activeworkspace -j | jq '.id')
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

current_monitor=$((($1 - 1% $monitor_count) + 1))

#echo $current_workspace
#echo $monitor_count
#echo $current_monitor

workspace_offset=0;

if [ "$current_workspace" -lt "6" ]; then
   workspace_offset=0;
elif [ "$current_workspace" -lt "11" ]; then
   workspace_offset=1;
elif [ "$current_workspace" -lt "16" ]; then
   workspace_offset=2;
elif [ "$current_workspace" -lt "21" ]; then
   workspace_offset=3;
elif [ "$current_workspace" -lt "26" ]; then
   workspace_offset=4;
elif [ "$current_workspace" -lt "31" ]; then
   workspace_offset=5;
elif [ "$current_workspace" -lt "36" ]; then
   workspace_offset=6;
elif [ "$current_workspace" -lt "41" ]; then
   workspace_offset=7;
elif [ "$current_workspace" -lt "46" ]; then
   workspace_offset=8;
elif [ "$current_workspace" -lt "51" ]; then
   workspace_offset=9;
elif [ "$current_workspace" -lt "56" ]; then
   workspace_offset=10;
fi


new_monitor=$(($current_monitor + $workspace_offset * $monitor_count))


window_addresses=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_workspace) | .address")
for address in $window_addresses; do
   hyprctl dispatch movetoworkspacesilent "$new_monitor,address:$address"
done

hyprctl dispatch workspace "$new_monitor"
