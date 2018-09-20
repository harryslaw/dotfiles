#!/bin/bash

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# completions
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# customise shell
set -o notify
tput smkx

# prompt
PS1='\[`[ $? = 0 ] && X=2 || X=1; tput setaf $X`\][\u@\h]\[`tput sgr0`\] $PWD\n\$ '

# keybindings
bind -r "\C-l" && bind "\C-l":clear-screen
bind -r "\C-e" && bind "\C-e":end-of-line
bind -r "\C-p" && bind "\C-p":history-search-backward
bind -r "\C-n" && bind "\C-n":history-search-forward

# User environment vars
export HISTFILE="$HOME/.history"
export HISTSIZE=2048

export LANGUAGE=en_GB
export LANG=en_GB.UTF-8
export LC_ALL=C

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"

# global exports
export PAGER=less
export EDITOR=vi
export VISUAL=vim

# panel exports
export PANEL_FIFO="/tmp/lemonbar-panel.fifo"
export PANEL_WIDTH=1348
export PANEL_HEIGHT=24
export PANEL_X=10
export PANEL_Y=8
export PANEL_FORE="#D8DEE9"
export PANEL_BACK="#111822"
export PANEL_FONT="-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1"

# aliases
alias ls='ls --color'
alias grep='grep --color'
alias tree='tree -aCF --dirsfirst'

# functions
ptpb_files() {
  for f in "$@"; do
    if [ -r "${f}" ]
    then
        printf %s\\n "\`${f}'" \
"$(printf %s "\`${f}'" | sed 's/./-/g')" \
"$(cat ${f} | curl -s -F c=@- https://ptpb.pw/ | awk '/^url:\s/{ print $1 $2 }')"
    fi
  done
}

# autostart x
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null
