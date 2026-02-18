echo $HOME
echo $(pwd)
if [ "$(pwd)" == "$HOME" ]; then
    neovide --fork ~/.config/nvim/
elif [ -n "$1" ]; then
    neovide --fork $1
else
    neovide --fork $(pwd)
fi
exit
