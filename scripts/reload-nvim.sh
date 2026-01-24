pids=$(pidof nvim | jq)

for pid in $pids; do
  echo $pid
  $(kill -s SIGUSR1 $pid)
done
