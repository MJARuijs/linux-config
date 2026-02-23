current_state=$(eww get $1)
# $(mkdir hoi/)
if [ $current_state = "false" ]; then
    echo "FALSE"
    $(eww update $1=true)
else
    echo "TRUE"
    echo $(eww update $1=false)
fi
