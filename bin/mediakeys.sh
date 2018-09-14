#!/bin/sh

usage() {
  printf %s\\n "Usage: $0 [? | help] [raise, lower, mute, play, next, prev, stop]"
}

while true
do
  case "$1" in
    ?|help)
      usage
      shift
      exit 0
      ;;
    raise)
      pactl set-sink-mute @DEFAULT_SINK@ false
      pactl set-sink-volume @DEFAULT_SINK@ +5%
      shift
      exit 0
      ;;
    lower)
      pactl set-sink-mute @DEFAULT_SINK@ false
      pactl set-sink-volume @DEFAULT_SINK@ -5%
      shift
      exit 0
      ;;
    mute)
      pactl set-sink-mute @DEFAULT_SINK@ toggle
      shift
      exit 0
      ;;
    play)
      shift
      exit 0
      ;;
    next)
      shift
      exit 0
      ;;
    prev)
      shift
      exit 0
      ;;
    stop)
      shift
      exit 0
      ;;
    notify)
      shift
      exit 0
      ;;
    *)
      usage
      shift
      exit 1
      ;;
  esac
done
