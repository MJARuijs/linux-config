monitor_count=$(hyprctl monitors all | grep -o Monitor | wc -l)

# monitor_count=1
command=""
for ((i = 1; i <= $monitor_count; i++)); do
    # command="ddcutil --display $i setvcp 10 $1 --sleep-multiplier 0 &"
    $(ddcutil --display $i setvcp 10 $1 --sleep-multiplier 0 &)
done
# $($command)
echo $command
