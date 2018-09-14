#!/bin/sh

cur="$(  bspc wm -d | sed -s 's/\,/\n/g' | grep -i -m 1 windowgap | cut -d':' -f 2 ; )"

if [ "${cur}" -eq "0" ]
then
  bspc config window_gap 10
else
  bspc config window_gap 0
fi
