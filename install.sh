source_dir=~/.config/linux-config/.config
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

ln -s ~/.config/linux-config/monitors/monitors-$HOSTNAME.conf ~/.config/linux-config/monitors/monitors-hostname.conf
ln -s ~/.config/linux-config/workspaces/workspaces-$HOSTNAME.conf ~/.config/linux-config/workspaces/workspaces-hostname.conf
