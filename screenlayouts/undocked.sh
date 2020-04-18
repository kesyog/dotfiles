#!/bin/sh
xrandr \
  --output eDP-1-1 --primary --mode 3840x2160 --pos 0x0 \
  --output eDP-1 --primary --mode 3840x2160 --pos 0x0 \
  --output DP-1-1-3 --off \
  --output DP-1-1-2 --off \
  --output DP-1-1-1 --off \
  --output DP-1-3 --off \
  --output DP-1-2 --off \
  --output DP-1-1 --off \
  --output DP-3 --off \
  > /dev/null 2>&1
