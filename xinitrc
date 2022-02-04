# Setup Xorg environment
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xsetroot -cursor_name left_ptr &

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Main monitor to 144hz
xrandr --output DP-2 --mode 2560x1440 --rate 144

# Map capslock key to escape
setxkbmap -option caps:ctrl

# Setup keybinds
xbindkeys

# Start the agent
eval $(ssh-agent)

# Setup terminal
# $HOME/.config/alacritty/startup.sh
#
#

export QT_QPA_PLATFORMTHEME=qt5ct

# Fsync/Futex2
export WINEFSYNC=1

# Use xinput2 for firefox
export MOZ_USE_XINPUT2=true

# Start dwm slstatus
~/.bin/dwm_status

# Start redshift
~/.bin/start_redshift

# Start dwm
exec dwm
