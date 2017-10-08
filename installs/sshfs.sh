#ATTENTION: SCRIPT WORKS FINE
# SSHFS DOES NOT MOUNT :-)
# @todo: fix and remove from issues
#sshfs:
pkg install -y fusefs-sshfs
# allow now
sysctl vfs.usermount=1
# https://0fury.de/2016/09/freebsd-sshfs-benutzen/
# add user to operator group (see ls -all /dev/fuse)
pw usermod user -G operator


# from
# http://blog.ataboydesign.com/2014/04/23/freebsd-10-mounting-usb-drive-with-ext4-filesystem/
# vi /etc/devfs.rules
# --------------------------------------------
# duck-duck-google devfs rules, rules should have unique names and ids
# here we have rule named localrules with id 5
grep 'localrules=5' /etc/devfs.rules > /dev/null || \
printf "[localrules=5] \
\n add path 'da*' mode 0660 group operator \
\n add path '*fus*' mode 0660 group operator \n" \
>> /etc/devfs.rules && 
#printf "\nadd path 'fuse*' mode 0660 group operator\n" >> /etc/devfs.rules 

#edit /etc/rc.conf to enable the devfs.rules(5) ruleset:
# vi /etc/rc.conf
#--------------------------------------------
grep 'localrules' /etc/rc.conf > /dev/null || \
printf 'devfs_load_rulesets="YES"\ndevfs_system_ruleset="localrules"' >> /etc/rc.conf

#Next allow regular user to mount file system:
# vi /etc/sysctl.conf
#--------------------------------------------
grep 'vfs.usermount' /etc/sysctl.conf > /dev/null|| printf "vfs.usermount=1" >> /etc/sysctl.conf

#sudo devfs rule -s 5 show #show devfs rules
#load devfs rules
/etc/rc.d/devfs restart
