#! /bin/sh

COUNT_FILE="lastWallpaper"
W_DIR="/home/mouhamed/Pictures/Wallpapers"
LAST_INDEX=0;

if [ ! -f $COUNT_FILE ]; then
  echo "0" > $COUNT_FILE
else
  wallpaperIndex=$(cat $COUNT_FILE)
  numberOfWallpapers=$(ls $W_DIR | wc -w)

  if [ $wallpaperIndex -ge $numberOfWallpapers ]; then
    echo "0" > $COUNT_FILE
    wallpaperIndex=0;
  fi
  
  i=0
  wallpaperFile=""

  for file in $(ls $W_DIR); do
    if [ $wallpaperIndex -eq $i ]; then wallpaperFile=$file; fi
    i=$((i + 1))
  done
  
  fullpath="$W_DIR"'/'"$wallpaperFile"

  feh --bg-fill $fullpath

  wallpaperIndex=$((wallpaperIndex + 1))
  echo $wallpaperIndex > $COUNT_FILE;
fi

