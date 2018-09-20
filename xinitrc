#!/usr/bin/sh

[ -f $HOME/.Xresources ] && xrdb -load $HOME/.Xresources
[ -f $HOME/.xmodmap ] && xmodmap $HOME/.xmodmap

# Initialise malconfigured
setxkbmap gb                # uk keymap
xinput set-prop 11 282 1    # touch to click

# no blank screen
xset s off
xset -dpms

# user fonts
xset +fp $HOME/.fonts
xset fp rehash

# daemonise agents
gpg-agent &
ssh-agent &

# startup programs
feh --no-fehbg --bg-fill $HOME/.wallpapers/elcapitan.jpg
redshift -r -l 51.51:0.13 &

# initialise display
xsetroot -cursor_name left_ptr
sxhkd &
exec bspwm
