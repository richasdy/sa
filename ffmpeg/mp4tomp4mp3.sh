#!/bin/bash
# FILES=/path/to/*
FILES=*.mkv
for f in $FILES
do
  # echo "Processing $f file..."
  # take action on each file. $f store current file name
  # cat $f

  # trim file name, 0 first char, 4 last char
  # f=${f:1}
  # f=${f:1:7}
  # f=${f:0:${#f}-4}
  # echo "$f"

  # echo "$f"
  # echo "${f:0:${#f}-4}"
  # source=$f
  source=\'${f}\'
  # source=${source// /\ }
  # source=${source//(/\(}
  # source=${source//)/\)}
  
  # dest=${f:0:${#f}-4}.mp3
  dest=\'${f:0:${#f}-4}_convert.mp4\'
  # dest=${dest// /\ }
  # dest=${dest//(/\(}
  # dest=${dest//)/\)}

  # echo "$source"
  # echo "$dest"
  # echo "ffmpeg -i $source -codec:a libmp3lame -qscale:a 6 $dest"
  eval "ffmpeg -i $source -acodec mp3 -vcodec copy $dest"
  # ffmpeg -i $source -codec:a libmp3lame -qscale:a 6 $dest

  
done