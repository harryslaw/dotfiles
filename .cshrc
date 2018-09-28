#!/bin/tcsh -f

if ($?tcsh && $?prompt) then
        bindkey "\e[1~" beginning-of-line # Home
        bindkey "\e[7~" beginning-of-line # Home rxvt
        bindkey "\e[2~" overwrite-mode    # Ins
        bindkey "\e[3~" delete-char       # Delete
        bindkey "\e[4~" end-of-line       # End
        bindkey "\e[8~" end-of-line       # End rxvt
endif
