#!/bin/tcsh -f

umask 022

setenv BLOCKSIZE        K

set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin \
            "$HOME/.local/bin")

setenv LANG             en_GB.UTF-8
setenv LC_CTYPE         C.UTF-8

setenv PAGER            more
setenv EDITOR           vi
setenv VISUAL           vim

setenv XDG_CONFIG_HOME  "$HOME/.config"

setenv PANEL_FIFO       "/tmp/lemonbar-panel.fifo"
setenv PANEL_GEOM	    "1348x24+10+10"
setenv PANEL_FORE	    "#d8dee9"
setenv PANEL_BACK	    "#111822"
setenv PANEL_FONT	    "Dina:pixelsize=12"

if ( $?prompt ) then
    alias ls        ls-F --color --group-directories-first
    alias grep      /usr/bin/grep --color
    alias tree      /usr/bin/tree -aCF --dirsfirst

    if ( $?tcsh ) then
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
