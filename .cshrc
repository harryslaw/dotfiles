#!/ bin / tcsh - f

#mask `rwxr - xr - x'
umask 022

#blocksize units
setenv BLOCKSIZE        M

#config file home
setenv XDG_CONFIG_HOME  "$HOME/.config"

#locale
setenv LANG             en_GB.UTF-8
setenv LC_CTYPE         C.UTF-8
setenv TZ               Europe/London

#panel exports
setenv PANEL_FIFO       /tmp/lemonbar-panel.fifo
setenv PANEL_GEOM	    1348x24+10+10
setenv PANEL_FORE	    '#d8dee9'
setenv PANEL_BACK	    '#111822'
setenv PANEL_FONT	    Dina:pixelsize=12

#user exports
setenv PAGER            zless
setenv EDITOR           vi
setenv VISUAL           vim
setenv COLUMNS          78
setenv GPG_TTY          `tty`

#aliases
alias ls        ls-F --group-directories-first
alias grep      /usr/bin/grep --color
alias tree      /usr/bin/tree -aCF --dirsfirst
alias diff      /usr/bin/diff --color
## verbose
alias cp        /usr/bin/cp -vp
alias rm        /usr/bin/rm -v
alias mv        /usr/bin/mv -v
alias ln        /usr/bin/ln -v

if ( $?prompt ) then
    set color
    set colorcat
    set filec
    set highlight
    set history = 4096
    set ignoreeof = 2
    set notify
    set prompt = '[%B%n@%M%b] %B%?%b %U%/%u\n[%U%h%u] %# '
    set savehist = 4096
    set status

    if ( $?tcsh ) then
        set autolist = ambiguous
        set complete
        set fignore = ( ~ .o )
        set histdup = prev
        set histfile = "$HOME/.history"
        set listflags = xa
        set listjobs = long
        set listlinks
        set printexitvalue
        set promptchars = '$#'
        set savehist = ( 4096 merge )

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
