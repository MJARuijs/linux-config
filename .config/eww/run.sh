monitors=$(hyprctl monitors -j | jq -r ".[] .id")
for monitorId in $monitors; do
    $(eww open bar --arg monitor=$monitorId --id $monitorId)
done
