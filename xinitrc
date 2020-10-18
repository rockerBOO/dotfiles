# Setup Xorg environment
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xsetroot -cursor_name left_ptr &

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

# Start dwm slstatus
~/.bin/dwm_status

# Start redshift
~/.bin/start_redshift

# Start dwm
exec dwm
