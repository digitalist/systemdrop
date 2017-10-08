#getting data from linux partition, read only:

pkg install -y fusefs-ext4fuse

# use now
kldload fuse
# load always
#replace to sysrc fuse_enable="YES" #?
grep fuse_load /boot/loader.conf  > /dev/null 2>&1  || echo 'fuse_load="YES"' >> /boot/loader.conf