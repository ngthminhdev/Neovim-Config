#!/bin/zsh

# Kiểm tra xem màn hình HDMI có được kết nối hay không
if xrandr | grep -q "HDMI-0 connected"; then
    if xrandr | grep -q "HDMI-0 connected 2560x1440"; then
      xrandr --output HDMI-0 --above eDP1 --auto 
    else
      xrandr --output eDP1 --left-of HDMI-0 --primary 
    fi
else
    xrandr --output eDP-1 --auto --primary
fi
