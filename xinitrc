# Setup Xorg environment
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xsetroot -cursor_name left_ptr &

# Set inside kernal startup
# xrandr --setprovideroutputsource modesetting NVIDIA-0

# Previous
# nvidia-settings --assign "CurrentMetaMode= DPY-2: nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0}, DPY-5: 2560x1440_144 @2560x1440 +1920+0 {ViewPortIn=2560x1440, ViewPortOut=2560x1440+0+0}"
nvidia-settings --assign "CurrentMetaMode=  DPY-2: nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0}, DPY-3: 2560x1440_144 @2560x1440 +1920+0 {ViewPortIn=2560x1440, ViewPortOut=2560x1440+0+0}"

# Might not need now
# xrandr --auto

# Main monitor to 144hz
xrandr --output DP-2 --mode 2560x1440 --rate 144

# Map capslock key to escape
setxkbmap -option caps:ctrl

# Setup keybinds
xbindkeys

# Start the agent
# eval $(ssh-agent)

# Setup terminal
# $HOME/.config/alacritty/startup.sh
#
#

# export QT_QPA_PLATFORMTHEME=qt5ct

# Scale screen UI elements (mostly for lmms)
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=1.275

export WLR_NO_HARDWARE_CURSORS=1

# Fsync/Futex2
# export WINEFSYNC=1

# Use xinput2 for firefox
export MOZ_USE_XINPUT2=true

# Start dwm slstatus
#~/.bin/dwm_status

# Start redshift
#~/.bin/start_redshift

# Start dwm
exec dwm
