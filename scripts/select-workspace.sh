#!/usr/bin/env bash
target_workspace=$((($1 - 1) * 5))

hyprctl dispatch workspace "$(($target_workspace + 2))"
hyprctl dispatch workspace "$(($target_workspace + 3))"
hyprctl dispatch workspace "$(($target_workspace + 4))"
hyprctl dispatch workspace "$(($target_workspace + 5))"
hyprctl dispatch workspace "$(($target_workspace + 1))"
