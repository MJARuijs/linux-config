timer_active=$(systemctl --user is-active wallpaper.timer)

if [ "$timer_active" == "active" ]; then
    $(systemctl --user stop wallpaper.timer)
else
    $(systemctl --user start wallpaper.timer)
fi
