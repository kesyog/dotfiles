#!/bin/sh
xrandr \
  --noprimary --fb 7680x2400 \
  --output eDP-1 --off \
  --output DP-1-2 --mode 1920x1200 --scale 2x2 --pos 3840x0 \
  --output DP-1-1 --scale 2x2 --mode 1920x1200 --pos 0x0 \
  --noprimary --fb 7680x2400 \
  --output eDP-1-1 --off \
  --output DP-1-1-2 --mode 1920x1200 --scale 2x2 --pos 3840x0 \
  --output DP-1-1-1 --scale 2x2 --mode 1920x1200 --pos 0x0 \
  --output DP-3 --off \
  > /dev/null 2>&1

