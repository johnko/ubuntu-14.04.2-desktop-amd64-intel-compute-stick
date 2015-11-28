#!/bin/sh

## Open terminal window with ctrl-alt-F1
# sudo su -
if [ "`whoami`" != "root" ]; then
	echo "ERROR: please sudo $0"
	exit 1
fi
apt-get update


## Change grub to text mode
sed -i 's/^GRUB_TIMEOUT=./GRUB_TIMEOUT=0/' /etc/default/grub
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=./GRUB_CMDLINE_LINUX_DEFAULT="text"/' /etc/default/grub
sed -i 's/^#GRUB_TERMINAL/GRUB_TERMINAL/' /etc/default/grub
update-grub2


## Remove desktop packages
apt-get -y install tasksel
tasksel remove ubuntu-desktop
aptitude -y purge '~c'


## Set up networking - and modify as required if using static IP addresses
#cat <<EOF >> /etc/network/interfaces
#auto eth0
#iface eth0 inet dhcp
#EOF
#ifup eth0


## Set up remote access
apt-get -y install ssh openssh-server


## Install xubuntu
apt-get -y install xubuntu-desktop


## Install server packages
tasksel install server


## Perform updates
apt-get update
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 16126D3A3E5C1192
#apt-get update


# Reboot to finish
echo "$0: You can now 'reboot'"

