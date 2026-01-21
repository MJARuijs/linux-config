#!/usr/bin/env bash

monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
monitors=$(hyprctl monitors -j | jq -r '.[] | .name')
monitor_array=($monitors)

workspace_monitor_assignment=$(cat "workspace-monitor-assignment.txt")
workspace_monitor_array=($workspace_monitor_assignment)

echo $monitors
workspace_count=10
workspace_conf=

for ((i = 0; i < $(($monitor_count * $workspace_count)); i += $monitor_count)); do

  workspace_counter=$i
  for monitor in $monitors; do
    workspace_index=$(($workspace_counter % $monitor_count))
    workspace_monitor_index=$((${workspace_monitor_array[$workspace_index]} - 1))
    new_line="workspace="$(($workspace_counter + 1))",monitor:"${monitor_array[$workspace_monitor_index]}

    if [[ $i = 0 ]]; then
      new_line="${new_line},default:true"
    fi

    new_line="${new_line}"$'\n'

    workspace_counter=$(($workspace_counter + 1))
    workspace_conf="${workspace_conf}${new_line}"
  done
done

echo "$workspace_conf" | tee ~/.config/hypr/workspaces.conf

##!/usr/bin/env bash
#
#monitors=$(hyprctl monitors -j | jq -r '.[] | .name')
#monitor_array=($monitors)
#
#monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
#workspace_count=10
#workspace_conf=
#
#for ((i = 0; i < $(($monitor_count * $workspace_count)); i += $monitor_count)); do
#
#  workspace_counter=$i
#  for monitor in $monitors; do
#    workspace_index=$(($workspace_counter % $monitor_count))
#    new_line="workspace="$(($workspace_counter + 1))":"${monitor_array[$workspace_index]}$'\n'
#    workspace_counter=$(($workspace_counter + 1))
#    workspace_conf="${workspace_conf}${new_line}"
#  done
#done
#
#echo "$workspace_conf" | tee workspaces.conf
