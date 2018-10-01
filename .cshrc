#!/bin/tcsh -f

# user exports
setenv PAGER            more
setenv EDITOR           vi
setenv VISUAL           vim
setenv COLUMNS          78

# aliases
alias ls        ls-F --group-directories-first
alias grep      /usr/bin/grep --color
alias tree      /usr/bin/tree -aCF --dirsfirst

if ( $?prompt ) then
    set color
    set colorcat
    set filec
    set highlight
    set history = 4096
    set ignoreeof = 2
    set notify
    set prompt = '[%B%n@%M%b] %B%?%b %U%/%u\n[%U%h%u] %# '
    set savehist
    set status

    if ( $?tcsh ) then
        set autolist = ambiguous
        set complete = enhance
        set echo_style = bsd
        set fignore = ( ~ .bak .old .o )
        set histdup = prev
        set listflags = xa
        set listjobs = long
        set listlinks
        set nokanji
        set printexitvalue
        set promptchars = '$#'

        bindkey "^W" backward-delete-word
        bindkey -k up history-search-backward
        bindkey -k down history-search-forward

        bindkey "\033[1~" beginning-of-line # Home
        bindkey "\033[7~" beginning-of-line # Home rxvt
        bindkey "\033[2~" overwrite-mode    # Ins
        bindkey "\033[3~" delete-char       # Delete
        bindkey "\033[4~" end-of-line       # End
        bindkey "\033[8~" end-of-line       # End rxvt
    endif

    if ( ! $?DISPLAY && $XDG_VTNR == 1 ) then
        exec startx
    endif
endif
