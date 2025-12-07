source_dir=~/.config/linux-config/.config
destination_dir=~/.config/

entries=("$source_dir"/*)

for entry in ${entries[@]}; do
  file_name="${entry##*/}"

  dest=$destination_dir$file_name

  echo "Dest: " $dest
  if [[ ! -d $dest || -z "$(ls -A $dest)" && ! -f $dest ]]; then
    if [[ -d $dest ]]; then
      echo "Removing dir " $dest
      $(rmdir $dest)
    else
      echo "Removing file " $dest
      $(rm $dest)
    fi
    ln -s $entry $destination_dir
  fi
done
