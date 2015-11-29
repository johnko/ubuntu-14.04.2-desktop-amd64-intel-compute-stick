#!/bin/sh

## Open terminal window with ctrl-alt-F1
# sudo su -
if [ "`whoami`" != "root" ]; then
	echo "ERROR: please sudo $0"
	exit 1
fi
apt-get update


## Remove desktop packages
apt-get -y install tasksel
tasksel install xubuntu-desktop


## Remove compiz
#apt-get -y purge compiz
#aptitude -y purge '~c'


# Reboot to finish
echo "$0: You can now 'reboot'"

