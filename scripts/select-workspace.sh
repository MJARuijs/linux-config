#!/usr/bin/env bash
target_workspace=$((($1 - 1) * 5))
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
# target_workspace=$((($1 - 1) * $monitor_count))

for ((i = $monitor_count; i > 0; i--)); do
  echo 'Switching to ' $(($target_workspace + $i))
  # hyprctl dispatch workspace "$(($target_workspace + $i))"
done
echo "Alt. " $(($target_workspace + 2))
echo "Alt. " $(($target_workspace + 3))
echo "Alt. " $(($target_workspace + 4))
echo "Alt. " $(($target_workspace + 5))
echo "Alt. " $(($target_workspace + 1))
hyprctl dispatch workspace "$(($target_workspace + 2))"
hyprctl dispatch workspace "$(($target_workspace + 3))"
hyprctl dispatch workspace "$(($target_workspace + 4))"
hyprctl dispatch workspace "$(($target_workspace + 5))"
hyprctl dispatch workspace "$(($target_workspace + 1))"
