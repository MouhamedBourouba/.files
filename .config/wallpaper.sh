#! /bin/sh

COUNT_FILE="lastWallpaper"
W_DIR="/home/mouhamed/Pictures/Wallpapers"

if [ ! -f $COUNT_FILE ]; then
  echo "0" > $COUNT_FILE
fi

WALLPAPER_INDEX=$(cat $COUNT_FILE)
NUMBER_OF_WALLPAPERS=$(ls $W_DIR | wc -w)

if [ $WALLPAPER_INDEX -ge $NUMBER_OF_WALLPAPERS ]; then
  echo "0" > $COUNT_FILE
  WALLPAPER_INDEX=0;
fi

i=0
WALLPAPER_FILE=""

for file in $(ls $W_DIR); do
  if [ $WALLPAPER_INDEX -eq $i ]; then WALLPAPER_FILE=$file; fi
  i=$((i + 1))
done

FULLPATH="$W_DIR"'/'"$WALLPAPER_FILE"
feh --bg-fill $FULLPATH

WALLPAPER_INDEX=$((WALLPAPER_INDEX + 1))
echo $WALLPAPER_INDEX > $COUNT_FILE;
