#!/bin/tcsh -f

# righteous mask `rwxr-xr-x'
umask 022

setenv BLOCKSIZE        M

set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin \
            "$HOME/.local/bin")

# locale
setenv LANG             en_GB.UTF-8
setenv LC_CTYPE         C.UTF-8

# config file home
setenv XDG_CONFIG_HOME  "$HOME/.config"

# panel exports
setenv PANEL_FIFO       "/tmp/lemonbar-panel.fifo"
setenv PANEL_GEOM	    "1348x24+10+10"
setenv PANEL_FORE	    "#d8dee9"
setenv PANEL_BACK	    "#111822"
setenv PANEL_FONT	    "Dina:pixelsize=12"
