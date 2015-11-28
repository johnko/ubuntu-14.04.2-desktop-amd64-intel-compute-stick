# Creating an Ubuntu Server on a Z3735F Device

Unfortunately creating an Ubuntu server on a Z3735F device is not as simple as just downloading and installing the server ISO from 'releases.ubuntu.com'. Firstly the server kernel does not have in-built eMMC support so the install script will not see your internal storage. Secondly the server kernel is a different version so it will not support the dynamic kernel modules for wifi and bluetooth.

However it is quite simple to convert a desktop installation to a server one. First download and install the Ubuntu desktop ISO for a Z3735F device (hint: use the ISO from 'https://drive.google.com/file/d/0B99O3A0dDe67MWptY01KazZOMWM' remembering to patch if using a 32-bit bootloader with 'linuxium-32bit-patch.sh' from 'https://drive.google.com/file/d/0B99O3A0dDe67R1BVS2ZPdWdKMk0 '). Once installed, do not log in but press 'Ctrl+Alt+F1' to open a virtual console. Now log in and enter the following commands to create your server. Afterwards you can then access your server remotely using 'ssh unsername@ip.address'.

## Open terminal window with ctrl-alt-F1

```
sudo su -
apt-get update
```

## Change grub to text mode

```
sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="text"/' /etc/default/grub
sed -i 's/^#GRUB_TERMINAL/GRUB_TERMINAL/' /etc/default/grub
update-grub2
```

## Remove desktop packages

```
apt-get -y install tasksel
tasksel remove ubuntu-desktop
aptitude -y purge '~c'
```

## Set up networking - and modify as required if using static IP addresses

```
cat <<EOF >> /etc/network/interfaces

auto eth0
iface eth0 inet dhcp
EOF
ifup eth0
```

## Set up remote access

```
apt-get -y install ssh openssh-server
```

## Install server packages

```
tasksel install server
```

## Perform updates

```
apt-get update
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 16126D3A3E5C1192
apt-get update
```

# Reboot to finish

```
reboot
```
