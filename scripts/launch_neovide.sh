echo $HOME
echo $(pwd)
if [ -n "$1" ]; then
    neovide --fork $1 $2 $3 $4 $5
elif [ "$(pwd)" == "$HOME" ]; then
    neovide --fork ~/.config/nvim/
else
    neovide --fork $(pwd)
fi
exit
