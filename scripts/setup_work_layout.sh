# $(hyprctl dispatch focusmonitor 1)
# $(firefox --private-window &)
# sleep 0.5

$(hyprctl dispatch focusmonitor 2)
$(firefox --new-instance)
sleep 0.5

$(hyprctl dispatch focusmonitor 4)
$(slack)
sleep 0.5
