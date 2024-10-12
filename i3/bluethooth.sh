#!/bin/zsh

bt_status=$(bluetoothctl show | grep 'Powered: yes' | awk '{print $2}')

if [ "$bt_status" == "yes" ]; then
    echo "ON"
else
    echo "OFF"
fi
