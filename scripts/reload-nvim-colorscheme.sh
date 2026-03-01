pids=$(pidof nvim | jq)
echo $pids
for pid in $pids; do
    $(kill -USR1 "$pid")
done
