#!/usr/bin/env bash

monitors=$(hyprctl monitors -j | jq -r '.[] | .name')
monitor_array=($monitors)

monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
workspace_count=10
workspace_conf=

for ((i = 0; i < $(($monitor_count * $workspace_count)); i += $monitor_count)); do

  workspace_counter=$i
  for monitor in $monitors; do
    workspace_index=$(($workspace_counter % $monitor_count))
    new_line="workspace="$(($workspace_counter + 1))":"${monitor_array[$workspace_index]}$'\n'
    workspace_counter=$(($workspace_counter + 1))
    workspace_conf="${workspace_conf}${new_line}"
  done
done

echo "$workspace_conf" | tee workspaces.conf
