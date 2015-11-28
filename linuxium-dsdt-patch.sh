#!/bin/sh

# Linuxium's installation script for audio DSDT patch

if [ ! `which iasl` ]; then
	apt-get -y install acpica-tools
	if [ ! `which iasl` ]; then
		echo "$0: Missing 'iasl' ... run 'apt-get -y install acpica-tools' mannually to install."
		exit
	fi
fi
if [ -d /tmp/dsdt.$$ ]; then
	echo "$0: Cannot create temporary work directory '/tmp/dsdt.$$' ... exiting."
	exit
fi
echo "$0: Started ..."
mkdir /tmp/dsdt.$$
cd /tmp/dsdt.$$
cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
iasl -d dsdt.dat > /dev/null 2>&1
cp dsdt.dsl dsdt.dsl.orig
patch dsdt.dsl <<+ > /dev/null 2>&1
@@ -3796,7 +3796,7 @@
                     Return (0x0F)
                 }
 
-                Return (Zero)
+                Return (0x0F)
             }
 
             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
+
iasl -tc dsdt.dsl > /dev/null 2>&1
cp dsdt.aml /boot
cat <<+ > /etc/grub.d/01_acpi
#! /bin/sh -e

# Uncomment to load custom ACPI table
GRUB_CUSTOM_ACPI="/boot/dsdt.aml"

# DON'T MODIFY ANYTHING BELOW THIS LINE!

prefix=/usr
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib

. \${libdir}/grub/grub-mkconfig_lib

# Load custom ACPI table
if [ x\${GRUB_CUSTOM_ACPI} != x ] && [ -f \${GRUB_CUSTOM_ACPI} ] \\
        && is_path_readable_by_grub \${GRUB_CUSTOM_ACPI}; then
    echo "Found custom ACPI table: \${GRUB_CUSTOM_ACPI}" >&2
    prepare_grub_to_access_device \`\${grub_probe} --target=device \${GRUB_CUSTOM_ACPI}\` | sed -e "s/^/ /"
    cat << EOF
acpi (\\\$root)\`make_system_path_relative_to_its_root \${GRUB_CUSTOM_ACPI}\`
EOF
fi
+
chmod 0755 /etc/grub.d/01_acpi
echo "$0: Installing ..."
update-grub2 > /dev/null 2>&1
cd
rm -rf /tmp/dsdt.$$
echo "$0: Finished."
