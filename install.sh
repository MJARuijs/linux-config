source_dir=~/.config/linux-config/.config
destination_dir=~/.config/

entries=("$source_dir"/*)

for entry in ${entries[@]}; do
  file_name="${entry##*/}"

  dest=$destination_dir$file_name

  if [[ ! -d $dest || -z "$(ls -A $dest)" && ! -f $dest ]]; then
    $(rmdir $dest)
    ln -s $entry $destination_dir
  fi
done
