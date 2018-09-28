#!/bin/bash

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# completions
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# colours
[[ -r "$HOME/.colours" ]] && . "$HOME/.colours"

# customise shell
set -o notify
set -o vi

# keybindings
bind -r "\C-l" && bind "\C-l":clear-screen
bind -r "\C-e" && bind "\C-e":end-of-line
bind -r "\C-p" && bind "\C-p":history-search-backward
bind -r "\C-n" && bind "\C-n":history-search-forward

# aliases
alias ls='ls --color'
alias grep='grep --color'
alias tree='tree -aCF --dirsfirst'

# functions
ptpb_files() {
  for f in "$@"; do
    if [[ -r "$f" ]]; then
        printf %s\\n "\`$f'" \
"$(printf %s "\`$f'" | sed 's/./-/g')" \
"$(cat $f | curl -s -F c=@- https://ptpb.pw/ | awk '/^url:\s/{ print $1 $2 }')"
    fi
  done
}
