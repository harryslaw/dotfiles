#!/bin/sh -

# locale exports
LANGUAGE=en_GB
LANG=en_GB.UTF-8
LC_ALL=C
export LANGUAGE LANG LC_ALL

# default program exports
PAGER=less
EDITOR=vi
VISUAL=vim
export PAGER EDITOR VISUAL

# history
HISTFILE="$HOME/.history"
HISTSIZE=8192
export HISTFILE HISTSIZE

# path exports
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

# panel exports
PANEL_FIFO="/tmp/lemonbar-panel.fifo"
PANEL_GEOM="1348x24+10+10"
PANEL_FONT="Dina:pixelsize=12"
PANEL_NAME="lemonbar"
export PANEL_FIFO PANEL_GEOM PANEL_FONT PANEL_NAME
