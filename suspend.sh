#!/bin/bash
interval=150

swayidle -w \
  timeout $interval 'swaylock -f -c 000000' \
  timeout $((interval*2)) 'hyprctl dispatch dpms off' \
  timeout $((interval*3)) 'systemctl suspend' \
    resume ' hyprctl dispatch dpms on' \
  before-sleep 'swaylock -f -c 000000'

