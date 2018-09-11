#!/bin/bash

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# bash_completions
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# customise shell
set -o notify

# keybindings
bind -r "\C-l" && bind "\C-l":clear-screen
bind -r "\C-e" && bind "\C-e":end-of-line
bind -r "\C-p" && bind "\C-p":history-search-backward
bind -r "\C-n" && bind "\C-n":history-search-forward

# prompt
PS1="[\u@\h \w]\$ "

# env variables
HISTFILE="${HOME}/.history"
HISTSIZE=2048
export LANG=en_GB.UTF-8
export LC_ALL=C
export PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/.gem/ruby/2.5.0/bin:${PATH}"

# gloabal exports
export PAGER=more
export EDITOR=vi
export VISUAL=vim
export GPGKEY='0x54225249'

# aliases
alias ls='ls --color'
alias grep='grep --color'
alias reboot='sudo reboot'
alias pip='python -m pip'

# autostartx
[[ -z ${DISPLAY} && ${XDG_VTNR} == 1 ]] && exec startx &> /dev/null
