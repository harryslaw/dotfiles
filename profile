#!/bin/sh

# env variables
HISTFILE="${HOME}/.history"
HISTSIZE=2048
LANG=en_GB.UTF-8
LC_ALL=C
PATH="${HOME}/.local/bin:${HOME}/.config/panel:${PATH}"
PANEL_FIFO="/tmp/panel-fifo"
PANEL_HEIGHT=24
PANEL_FONT="-uw-ttyp0-medium-r-normal--13-120-75-75-c-70-iso8859-1"
PANEL_WM_NAME=lemonbar
XDG_CONFIG_HOME="${HOME}/.config"
export HISTFILE HISTSIZE
export LANG LC_ALL
export PANEL_FIFO PANEL_HEIGHT PANEL_FONT PANEL_WM_NAME
export PATH XDG_CONFIG_HOME

# autostartx
if [ -z ${DISPLAY} ]
then
  if [ ${XDG_VTNR} == 1 ]
  then
    exec startx &> /dev/null
  fi
fi
