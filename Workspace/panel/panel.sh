#!/bin/sh -

bspc subscribe report > "$PANEL_FIFO" &
when -i1 -sf "S%a %Y-%m-%d, %H:%M:%S" > "$PANEL_FIFO" &
