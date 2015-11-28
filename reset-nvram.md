All that has happened is the NVRAM and ESP are out of sync. This can be easily fixed by the following:

1. Start with the ICS switched off.
2. Connect your LiveCB USB.
3. Power on the ICS and press F10 and boot from the USB.
4. Open a terminal windows and enter:

```
sudo su -
apt-get install efibootmgr
```

5. Remove any boot entries that may have been created through the earlier install or attempts to get things working by entering:

```
for BOOTENTRY in 0 1 2 3 4 5 6 7 8 9
do
efibootmgr -b ${BOOTENTRY} -B
done
```

6. Create an Ubuntu boot entry by entering:

```
efibootmgr -c -d /dev/mmcblk0 -p 1 -l \\EFI\\ubuntu\\grubx64.efi -L Ubuntu
```

7. Reboot and press F10 and boot from the newly created Ubuntu entry.
8. Repeat from step 1 if it fails.
9. Remove USB and reboot.

