echo $HOME
echo $(pwd)
if [ "$(pwd)" == "$HOME" ]; then
  neovide --fork ~/.config/nvim/
else
  neovide --fork $(pwd)
fi
exit;
