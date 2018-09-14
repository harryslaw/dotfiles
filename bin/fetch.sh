#!/bin/sh

# kernel
kernel="$( uname -r ; )"

# shell
shell="${SHELL}"

# model
model="$( cat /sys/devices/virtual/dmi/id/product_name ; )"

# os
os="$( cat /etc/os-release | awk -F "=" '/PRETTY_NAME/ {printf $2}' | sed 's/\"//g' ; )"

# packages number
case "${os}" in
  *[dD]ebian*) packages="$( dpkg -l | wc -l ; )" ;;
  *) packages="$( pacman -Q | wc -l ; )" ;;
 esac

# get wm
get_wm() {
    id="$( xprop -root -notype _NET_SUPPORTING_WM_CHECK | sed 's/.*\s//' ; )"
    wm="$( xprop -id ${id} -notype -len 100 -f _NET_WM_NAME 8t | grep _NET_WM_NAME | cut -d' ' -f 3 | sed 's/\"//g' ; )"
    # workaround for i3 gaps
    if [ "${wm}" = 'i3' ]
    then
        if [ i3 -v | grep -q gaps ]
        then
            wm='i3-gaps'
        fi
    fi
}

# to run before output
get_wm

# output
cat << EOF
     model ${model}
    kernel ${kernel}
        os ${os}
     shell ${shell}
        wm ${wm}
  packages ${packages}
EOF
