#!/bin/bash

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# bash_completions
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# customise shell
set -o notify
tput smkx

# prompt
PS1='\[`[ $? = 0 ] && X=2 || X=1; tput setaf $X`\][\u@\h]\[`tput sgr0`\] $PWD\n\$ '
export PS1

# keybindings
bind -r "\C-l" && bind "\C-l":clear-screen
bind -r "\C-e" && bind "\C-e":end-of-line
bind -r "\C-p" && bind "\C-p":history-search-backward
bind -r "\C-n" && bind "\C-n":history-search-forward

#global exports
export PAGER=less
export EDITOR=vi
export VISUAL=vim
export GPGKEY=0x54225249

# aliases
alias ls='ls --color'
alias grep='grep --color'
alias reboot='sudo reboot'
alias pip='python -m pip'
alias clng='clang -Werror -pedantic -fshow-column -fshow-source-location -fcolor-diagnostics -fdiagnostics-show-template-tree'

# functions
ptpb_files() {
  for f in "$@"
  do
    if [ -r "${f}" ]
    then
      printf %s\\n "\`${f}'" "$(printf "\`${f}'" | sed 's/./-/g')" "$(cat ${f})" \
  | curl -s -F c=@- https://ptpb.pw/ | sed -n 's/^url:\s\(.*\)$/'${f}' : \1/p'
    fi
 done
}
