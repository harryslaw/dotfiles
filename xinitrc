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

## agents
eval gpg-agent &
eval ssh-agent &

## bspwm
xsetroot -cursor_name left_ptr
feh --no-fehbg --bg-scale ~/.wallpapers/686845.jpg
sxhkd &
exec bspwm
