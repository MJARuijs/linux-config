#!/usr/bin/env bash
monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)
# echo "MonitorCount: $monitor_count"

first_monitor_workspace_index=$((($1 - 1) * $monitor_count))
# echo "firstMonitorIndex: $first_monitor_workspace_index"

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
# echo "Active workspace: $current_workspace"

current_monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

current_cursor_position=$(hyprctl cursorpos)
parsed_current_cursor_position=${current_cursor_position//, / }
cursor_x=-1
cursor_y=-1

for t in $parsed_current_cursor_position; do
    if [ $cursor_x == -1 ]; then
        cursor_x=$t
    else
        cursor_y=$t
    fi
done

target_workspace=$(((((($current_workspace - 1)) % $monitor_count)) + first_monitor_workspace_index + 1))

# Look for floating windows first
current_window=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $target_workspace and .at[0] <= $cursor_x and (.at[0] + .size[0]) >= $cursor_x and .at[1] <= $cursor_y and (.at[1] + .size[1]) >= $cursor_y and .floating == true) | .address")

# If no floating window was found, look for a FullScreen window
if [[ -z "$current_window" ]]; then
    current_window=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $target_workspace and .at[0] <= $cursor_x and (.at[0] + .size[0]) >= $cursor_x and .at[1] <= $cursor_y and (.at[1] + .size[1]) >= $cursor_y and .fullscreen == 2) | .address")
    # echo "currentwindow:" $current_window
fi

# If no fullscreen window was found either, look for tiled windows
if [[ -z "$current_window" ]]; then
    current_window=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $target_workspace and .at[0] <= $cursor_x and (.at[0] + .size[0]) >= $cursor_x and .at[1] <= $cursor_y and (.at[1] + .size[1]) >= $cursor_y) | .address")
    # echo "currentwindow:" $current_window
fi

for ((i = $monitor_count; i > 0; i--)); do
    # echo 'Switching to ' $(($first_monitor_workspace_index + $i))
    # hyprctl dispatch workspace "$(($first_monitor_workspace_index + $i))"
    hyprctl dispatch "hl.dsp.focus({workspace=\"$(($first_monitor_workspace_index + $i))\"})"
done

# echo $target_workspace
# echo $first_monitor_workspace_index
# echo $parsed_current_cursor_position
# echo $cursor_x
# echo $cursor_y

$(hyprctl dispatch "hl.dsp.focus({monitor = \"$current_monitor_id\"})")
$(hyprctl dispatch "hl.dsp.focus({window = \"address:"$current_window"\"})")
$(hyprctl dispatch "hl.dsp.cursor.move({x=$cursor_x, y=$cursor_y})")

# $(hyprctl dispatch focuswindow "address:$current_window")
# $(hyprctl dispatch focusmonitor $current_monitor_id)
# $(hyprctl dispatch movecursor $parsed_current_cursor_position)
