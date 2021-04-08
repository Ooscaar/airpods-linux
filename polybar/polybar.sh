#!/bin/sh
# shell script to prepend i3status with more stuff

status=$(systemctl is-active bluetooth.service)
airpods=$(tail -1 /tmp/airpods.out)

if [ "$status" == "inactive" ]; then
	echo "Disconnected"
else
	echo "$airpods"
fi
