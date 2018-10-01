#!/bin/sh -

[ -f $HOME/.Xresources ] && xrdb -load $HOME/.Xresources
[ -f $HOME/.xmodmap ] && xmodmap $HOME/.xmodmap

# Initialise malconfigured
setxkbmap gb                # uk keymap
xinput set-prop 11 280 1    # touch to click

# screen brightness
xrandr --output eDP-1 --brightness 1.05

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
pulseaudio --start &
feh --no-fehbg --bg-fill $HOME/.wallpapers/elcapitan.jpg

# initialise display
xsetroot -cursor_name left_ptr
sxhkd &
exec bspwm
