#!/bin/sh -

if xdo id -a "$PANEL_NAME" > /dev/null
then
	printf "%s\n" "The panel is already running." >&2
	exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

if [ -f "$HOME/.colours" ]
then
    . "$HOME/.colours"
else
    printf %s\\n "Colours file not found"
    exit 1
fi

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo -m 0600 "$PANEL_FIFO"

sys_tray()
{
    while true
    do
        WHEN=$(when -f '%a %H:%M:%S %Y-%m-%d')
        printf %s\\n "S$WHEN"
        sleep 0.1
    done
}

bspc subscribe report > "$PANEL_FIFO" &
xtitle -sf 'T%s\n' > "$PANEL_FIFO" &
sys_tray > "$PANEL_FIFO" &

bar_loop()
{
    num_mon=$( bspc query -M | wc -l; )
    while read -r line
    do
        case "$line" in
            S*)
                # sys output
                sys="%{F$PANEL_SYS_FG} ${line#?} %{F-}"
                ;;
            T*)
                # xtitle output
                title="%{F$PANEL_TITLE_FG} ${line#?} %{F-}"
                ;;
            W*)
                # bspwm's state
                wm=
                IFS=':'
                set -- ${line#?}
                while [ $# -gt 0 ]
                do
                    item=$1
                    name=${item#?}
                    case $item in
                        [mM]*)
                            case $item in
                                m*)
                                    # monitor
                                    FG=$PANEL_MONITOR_FG
                                    BG=$PANEL_BACK
                                    on_focused_monitor=
                                    ;;
                                M*)
                                    # focused monitor
                                    FG=$PANEL_FOCUSED_MONITOR_FG
                                    BG=$PANEL_FOCUSED_MONITOR_BG
                                    on_focused_monitor=1
                                    ;;
                            esac
                            [ $num_mon -lt 2 ] && shift && continue
                            wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B- F-}"
                            ;;
                        [fFoOuU]*)
                            case $item in
                                f*)
                                    # free desktop
                                    FG=$PANEL_FREE_FG
                                    BG=$PANEL_BACK
                                    UL=$BG
                                    ;;
                                F*)
                                    if [ "$on_focused_monitor" ] ; then
                                        # focused free desktop
                                        FG=$PANEL_FOCUSED_FREE_FG
                                        BG=$PANEL_FOCUSED_FREE_BG
                                        UL=$BG
                                    else
                                        # active free desktop
                                        FG=$PANEL_FREE_FG
                                        BG=$PANEL_FREE_BG
                                        UL=$PANEL_FOCUSED_FREE_BG
                                    fi
                                    ;;
                                o*)
                                    # occupied desktop
                                    FG=$PANEL_OCCUPIED_FG
                                    BG=$PANEL_BACK
                                    UL=$BG
                                    ;;
                                O*)
                                    if [ "$on_focused_monitor" ] ; then
                                        # focused occupied desktop
                                        FG=$PANEL_FOCUSED_OCCUPIED_FG
                                        BG=$PANEL_FOCUSED_OCCUPIED_BG
                                        UL=$BG
                                    else
                                        # active occupied desktop
                                        FG=$PANEL_OCCUPIED_FG
                                        BG=$PANEL_OCCUPIED_BG
                                        UL=$PANEL_FOCUSED_OCCUPIED_BG
                                    fi
                                    ;;
                                u*)
                                    # urgent desktop
                                    FG=$PANEL_URGENT_FG
                                    BG=$PANEL_URGENT_BG
                                    UL=$BG
                                    ;;
                                U*)
                                    if [ "$on_focused_monitor" ] ; then
                                        # focused urgent desktop
                                        FG=$PANEL_FOCUSED_URGENT_FG
                                        BG=$PANEL_FOCUSED_URGENT_BG
                                        UL=$BG
                                    else
                                        # active urgent desktop
                                        FG=$PANEL_URGENT_FG
                                        BG=$PANEL_URGENT_BG
                                        UL=$PANEL_FOCUSED_URGENT_BG
                                    fi
                                    ;;
                            esac
                            wm="${wm}%{F${FG}}%{B${BG}}%{U${UL}}%{+u}%{A:bspc desktop -f ${name}:} ${name} %{A}%{B- F-}%{-u}"
                            ;;
                        [LTG]*)
                            # layout, state and flags
                            wm="${wm}%{F$PANEL_STATE_FG}%{B$PANEL_BACK} ${name} %{B- F-}"
                            ;;
                    esac
                    shift
                done
                ;;
        esac
        printf %s\\n "%{l}$wm%{c}$title%{r}$sys"
    done
}

bar_loop < "$PANEL_FIFO" | lemonbar -p -n "$PANEL_NAME" -g "$PANEL_GEOM" \
                                    -B "$PANEL_BACK" -F "$PANEL_FORE" \
                                    -f "$PANEL_FONT" | sh &

wid=$(xdo id -m -a "$PANEL_NAME")
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
