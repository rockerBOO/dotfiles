#!/bin/bash
# https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/
# Update alacritty config to apply Xresources color scheme

# Target file
target_file="$HOME/.config/alacritty/alacritty.yml"

# copy input file to temporary file for black magic fuckery
# (alacritty applies colors when the config file is written, so we want to do it
# all in one write)
cp $target_file.in $target_file.tmp

# Grab colors from Xresources
xrdb ~/.Xresources

# Numbered colors
for i in {0..15}
do
    v=`xrdb -query | awk '/*.color'"$i":'/ { print substr($2,2) }'`
    eval "sed -i 's/%cl${i}%/\x270x${v}\x27/g' $target_file.tmp";
done

# Named colors
foreground=`xrdb -query | awk '/*.foreground/ { print substr($2,2) }'`
background=`xrdb -query | awk '/*.background/ { print substr($2,2) }'`
sed -i "s/%clfg%/\x270x${oreground}\x27/g" $target_file.tmp
sed -i "s/%clbg%/\x270x${background}\x27/g" $target_file.tmp

# Finally, replace target file with our updated one
rm $target_file
mv $target_file.tmp $target_file
