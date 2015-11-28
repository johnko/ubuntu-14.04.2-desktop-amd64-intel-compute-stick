# ubuntu-14.04.2-desktop-amd64-intel-compute-stick

Scripts released by Linuxium / [Ian Morrison](https://plus.google.com/+IanMORRISON)

Original instructions by Ian Morrison follows:

# Intel Compute Stick (using 64-bit bootloader)

Download the 64-bit Ubuntu 14.04.2 ISO from http://old-releases.ubuntu.com/releases/trusty/ and write to a USB using 'Rufus' on Windows or 'dd' on Linux

Plug the USB into the device and power-up and use F2 to change the bootloader to 64-bit (i.e. Ubuntu 14.04)

Now use F10 to boot from the USB and install Ubuntu. You will now have a bootable Ubuntu but without bluetooth, wifi and sound

Reboot into Ubuntu and download 'linuxium-z3735f-patch.sh' from https://drive.google.com/file/d/0B99O3A0dDe67endsMWtBT3k5ZUE

Open a terminal window and make the file executable (chmod 700 linuxium-z3735f-patch.sh) and execute the shell script as root (sudo ./linuxium-z3735f-patch.sh)

This will build and install all the required drivers for Ubuntu
Once finished reboot your device to enable a fully functional Ubuntu
