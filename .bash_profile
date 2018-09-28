#!/bin/bash

# sources
[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
if [[ $- == *i* ]];  then
    [[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
fi

# autostart x
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null
