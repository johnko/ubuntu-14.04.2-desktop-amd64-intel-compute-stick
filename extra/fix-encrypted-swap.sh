#!/bin/sh

sudo mkswap /dev/mmcblk0p3
sudo ecryptfs-setup-swap

