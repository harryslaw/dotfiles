#!/usr/bin/sh -

# Load local X configures if they exist
[ -f "$HOME/.Xresources" ] && xrdb -load "$HOME/.Xresources"
[ -f "$HOME/.xmodmap" ] && xmodmap "$HOME/.xmodmap"

# keymap and tap to click
setxkbmap gb                # uk keymap
## use `xinput list` for device, `xinput list-props <device>` for the following
###             dev prop value
xinput set-prop 11  280  1

# no blank screen
#xset s off
#xset -dpms

# user fonts
xset +fp "$HOME/.fonts"
xset fp rehash

# daemonise agents
gpg-agent &
ssh-agent &

# startup programs
## if not using `systemctl --user enable pulseaudio.service`
#pulseaudio --start &
feh --no-fehbg --bg-fill "$HOME/.wallpapers/elcapitan.jpg"
redshift -r -l 51.51:0.13 &

# initialise display
xsetroot -cursor_name left_ptr
sxhkd &
exec bspwm
