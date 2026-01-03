#!/usr/bin/env bash
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
target_workspace=$((($1 - 1) * $monitor_count))

for ((i = $monitor_count; i > 0; i--)); do
  echo 'Switching to ' $(($target_workspace + $i))
  hyprctl dispatch workspace "$(($target_workspace + $i))"
done
