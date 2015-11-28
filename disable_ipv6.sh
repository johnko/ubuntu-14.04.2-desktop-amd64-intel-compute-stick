#!/bin/sh

if [ "`whoami`" != "root" ]; then
	echo "ERROR: please run sudo $0"
	exit 1
fi

sysctl net.ipv6.conf.all.disable_ipv6=1
echo sysctl net.ipv6.conf.all.disable_ipv6=1 >> /etc/sysctl.conf
