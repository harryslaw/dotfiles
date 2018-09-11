#!/bin/sh

## set keymap
setxkbmap gb

## no blank screen
xset s off
xset -dpms

## load xresources
if [ -f "${HOME}/.Xresources" ]
then
  xrdb -merge "${HOME}/.Xresources"
fi

## load xmodmap
if [ -f "${HOME}/.xmodmap" ]
then
  xmodmap "${HOME}/.xmodmap"
fi

## basic starups
pulseaudio --start &
feh --no-fehbg --bg-fill ~/.wallpapers/692487.jpg

## bspwm
xsetroot -cursor_name left_ptr
sxhkd &
"${HOME}/bin/sbar.sh" &
exec "bspwm -c ${HOME}/.config/bspwm/bspwmrc"
