#!/usr/bin/env bash
# run under sudo!
# you must have virtualbox installed. see virtualbox.sh
# you can use RAW ACCESS mode as a perverted ext4fs R/W driver to get access to your Linux partition
# before converting it to ZFS
# from freebsd wiki
# from https://hpcworks.wordpress.com/2016/02/13/raw-disk-access-in-virtualbox-4-3-on-freebsd-10-2/

# RAW ACCESS: ==========================================================================================================

# /etc/devfs.rules must exist and include these two lines:
#[system=10]
#add path 'ada*' mode 0660 group operator
## ... other rules like: add path 'usb/*' mode 0660 group operator

# /etc/rc.conf must include: ===========================================================================================
# devfs_system_ruleset="system"


# restart devfs to apply rules: ========================================================================================
# /etc/rc.d/devfs restart


# create fake vmdk file, filename MUST be absolute =====================================================================
#sudo VBoxManage internalcommands createrawvmdk -filename /usr/home/user/mnt/vbox/ada0.vmdk -rawdisk /dev/ada0
    #it should say RAW host disk access VMDK file /usr/home/user/mnt/vbox/ada0.vmdk created successfully.

# fix permissions ======================================================================================================
#sudo chown user:user ada0.vmdk
#sudo chmod 0660 ada0.vmdk


# IMPORTANT: Host I/O CACHE ============================================================================================
# read about it here: https://www.virtualbox.org/manual/ch05.html
# if your raw disk hangs your guest os possible solution is:
# either use GUI: VM Settings->Storage->Use Host I/O cache or:
# VBoxManage storagectl "VM name" --name <controllername> --hostiocache on
# VBoxManage storagectl "ubuntu_16" --name SATA --hostiocache on