#!/bin/sh
 
IP1=$(/usr/bin/ip -4 addr | grep "eth0" | cut -d " " -f 9 | grep -v "scope")

if [ "$IP1" = "UP" ]; then
    echo "%{F#2495e7} %{F#ffffff}$(/usr/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}')%{u-}"
else
    echo "%{F#2495e7} %{F#ffffff}$(/usr/sbin/ifconfig wlan0 | grep "inet " | awk '{print $2}')%{u-}"

fi
