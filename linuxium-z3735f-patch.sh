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

apt-get update
apt-get -y install dkms
cat <<+ > /etc/apt/sources.list.d/chestersmill.list
deb http://oem.archive.canonical.com/updates/ trusty-chestersmill public
deb-src http://oem.archive.canonical.com/updates/ trusty-chestersmill public
+
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22
apt-get update
apt-get -y install chestersmill-settings


# remove bluetooth but keep wifi
apt-get -y install oem-audio-i915-baytrail-dkms rtl8723bs-dkms
apt-get -y remove rtl8723bs-bluetooth-dkms rtl8723bs-bluetooth-misc

echo "$0: Now 'reboot' device."

