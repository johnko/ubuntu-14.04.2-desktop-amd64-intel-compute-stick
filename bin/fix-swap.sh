#!/bin/sh

if [ "`whoami`" != "root" ]; then
	echo "ERROR: please sudo $0"
	exit 1
fi

echo /dev/mmcblk0p3 none swap sw 0 0 >> /etc/fstab
mkswap /dev/mmcblk0p3
swapon /dev/mmcblk0p3

