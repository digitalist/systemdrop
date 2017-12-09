#!/usr/bin/env bash
# when sublime or  maybe some other program depending on linux shared memory doesn't work
# https://forums.freebsd.org/threads/55757/#post-317787

#It will give you a shell with root rights. Then you won't have to type sudo each time for the next commands.

#2. Create a directory for the tmpfs filesystem. For instance:
  mkdir -p /tmpfs

# 3. Edit the /etc/fstab (with vi for instance) to add the following line at the end of the file:

 grep "tmpfs" /etc/fstab >> /dev/null ||  echo "tmpfs     /tmpfs     tmpfs   rw,mode=777   0   0" >> /etc/fstab

#4. Mount the tmpfs filesystem:

 mount /tmpfs


#5. Edit the file /etc/devfs.conf (with vi for instance) to add the following line at the end of the file:
 grep "tmpfs" /etc/devfs.conf  >> /dev/null ||  echo "link   /tmpfs   shmb" >> /etc/devfs.conf




#6. Restart devfs
 /etc/rc.d/devfs restart