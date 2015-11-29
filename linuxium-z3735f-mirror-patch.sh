#!/bin/sh

# Linuxium's installation script for upgrading Ubuntu with Canonical's Z3735F customizations

if [ -d /target ]; then
	echo "$0: Do not run this script from a LiveCD ... exiting."
	exit
fi

DEFAULT_GATEWAY=`ip r | grep default | cut -d ' ' -f 3`
if ( ! ping -q -w 1 -c 1 "${DEFAULT_GATEWAY}" > /dev/null 2>&1 ); then
	echo "$0: Not connected to internet ... exiting."
	exit
fi

cat <<+ > /etc/apt/sources.list
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse

deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse

deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse

deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse

deb http://extras.ubuntu.com/ubuntu trusty main
deb-src http://extras.ubuntu.com/ubuntu trusty main
+
apt-get update
apt-get -y install dkms
cat <<+ > /etc/apt/sources.list.d/chestersmill.list
deb http://oem.archive.canonical.com/updates/ trusty-chestersmill public
deb-src http://oem.archive.canonical.com/updates/ trusty-chestersmill public
+
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22
apt-get update
apt-get -y install chestersmill-settings
echo "$0: Now 'reboot' device."
