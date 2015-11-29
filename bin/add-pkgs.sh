#!/bin/sh

if [ -e ./pkg ]; then
	sudo install -m 755 ./pkg /usr/bin/pkg
fi

sudo -E apt-get update
#sudo -E apt-get install linux-generic-lts-utopic
sudo -E apt-get install git tmux tasksel openssh-client
#xubuntu-desktop

