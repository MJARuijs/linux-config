### Create required styling files that don't get pushed to git
$(touch ~/linux-config/.config/ohmyposh/EDM115-newline.omp.json)
$(touch ~/linux-config/current_wallpaper)

### Create sym-links
source_dir=~/linux-config/.config
destination_dir=~/.config/

entries=("$source_dir"/*)

for entry in ${entries[@]}; do
    file_name="${entry##*/}"

    dest=$destination_dir$file_name

    if [[ ! -d $dest || -z "$(ls -A $dest)" && ! -f $dest ]]; then
        if [[ -d $dest ]]; then
            echo "Removing dir " $dest
            $(rmdir $dest)
        else
            echo "Removing file " $dest
            $(rm $dest)
        fi
        echo "Creating sym-link from" $entry "to" $destination_dir
        ln -s $entry $destination_dir
    fi
done

hyprctl reload

# Install software dependencies
if [[ ! -d "$HOME/Software/eww" ]]; then
    $(curl -L -o $HOME/Software/eww.zip https://github.com/elkowar/eww/archive/refs/heads/master.zip)
    $(unzip $HOME/Software/eww.zip -d $HOME/Software/)
    $(rm $HOME/Software/eww.zip)
    $(mv $HOME/Software/eww-master/ $HOME/Software/eww/)
    $(
        cd $HOME/Software/eww
        cargo build --release --no-default-features --features=wayland
    )
else
    echo "Eww already installed"
fi
