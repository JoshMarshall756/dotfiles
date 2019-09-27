#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Find all monitors and launch all bars on them monitors
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -l info -c ~/.config/polybar/config main &
  done
else 
  polybar --reload ~./config/polybar/config main &
fi

echo "Bars launched..."
