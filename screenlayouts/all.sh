#!/bin/sh
xrandr \
  --fb 7680x4560 \
  --output eDP-1 --primary --mode 3840x2160 --pos 1920x2400 \
  --output DP-1-2 --mode 1920x1200 --scale 2x2 --pos 3840x0 \
  --output DP-1-1 --scale 2x2 --mode 1920x1200 --pos 0x0 \
  --output eDP-1-1 --primary --mode 3840x2160 --pos 1920x2400 \
  --output DP-1-1-2 --mode 1920x1200 --scale 2x2 --pos 3840x0 \
  --output DP-1-1-1 --scale 2x2 --mode 1920x1200 --pos 0x0 \
  --output DP-3 --off \
  > /dev/null 2>&1
