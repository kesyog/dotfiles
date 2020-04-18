#!/bin/sh
xrandr \
  --output eDP-1-1 --primary --mode 3840x2160 --pos 0x2160 \
  --output eDP-1 --primary  --mode 3840x2160 --pos 0x2160 \
  --output DP-3 --mode 1920x1080 --scale 2x2 --pos 0x0 \
  > /dev/null 2>&1
