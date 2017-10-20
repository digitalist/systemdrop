#!/usr/bin/env bash
# run under sudo.
# you MUST install ports (see installs/ports.sh  or freebsd handbook)



# HELPER FUNCTION ======================================================================================================
VERSION=$(freebsd-version | egrep -o "[0-9.]+-[A-Z]+")
ARCH=$(uname -m)

function fix_permissions_and_flags(){
#unpacks txz file and removes read-only-flags
tar -ztf $1  | cut -c 2- |
  while IFS= read -r line
  do
    #echo "$line"

    if [ -f "$line" ]
        then
            #echo "$line is a file"
            #ls -lo $line
            chflags noschg $line #remove imutable flags
            chmod g+w $line
        #else
        #    echo "$line is not a file"
    fi
  done
}



# CHECK IF PORTS ARE INSTALLED =========================================================================================
ls /usr/ports/emulators/virtualbox-ose > /dev/null 2>&1 || printf "\n\n\nNO PORTS TREE  FOUND\n see installs/ports.sh\n\n\n"



# IF THERE ARE NO 32 BIT LIBRARIES INSTALLED ===========================================================================
# @todo: update documentation at https://www.freebsd.org/doc/handbook/virtualization-host-virtualbox.html
# if you forgot to install 32 bit libraries, running `make install clean` in  `/usr/ports/emulators/virtualbox-ose`
# will throw an error,
# solution by @freebsd.forum:kpa from https://forums.freebsd.org/threads/45878/reply?quote=256635
# Extract the lib32.txz tarball from the distribution sets (should be at /usr/freebsd-dist on the installation media)
# at the root directory and that should be all.
#ldconfig -32 /usr/lib32/ /usr/local/lib32/compat/

# let's get that package from http mirror:
# example $ARCH $VERSION: http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/11.1-RELEASE/lib32.txz

# curl those libs from mirror (ftp is evil)
printf "\n processing libs32.txz"
ls lib32.txz > /dev/null 2>&1 || curl -O http://ftp.freebsd.org/pub/FreeBSD/releases/$ARCH/$VERSION/lib32.txz
## RISKY BUSINESS: let's extract that tar to / root

fix_permissions_and_flags lib32.txz
#sudo tar xvf lib32.txz -C / && rm lib32.txz || printf "\n\n\nError extracting file. HOW ABOUT A CUP OF ... sudo?\n\n\n"
sudo tar xvf lib32.txz -C /  || printf "\n\n\nError extracting file. HOW ABOUT A CUP OF ... sudo?\n\n\n"

# @freebsd.forum:SirDice says we must use ldconfig: https://forums.freebsd.org/threads/45878/reply?quote=256773
ldconfig -32 /usr/lib32/ # /usr/local/lib32/compat/



# IF THERE ARE NO KERNEL SOURCES  ======================================================================================
## We also need kernel sources: http://blog.ataboydesign.com/2014/03/17/freebsd-installing-virtualbox-no-rule-to-make-target-syskernbus_if-m-compile-error/
printf "\n processing src.txz"
ls src.txz > /dev/null 2>&1 || curl -O http://ftp.freebsd.org/pub/FreeBSD/releases/$ARCH/$VERSION/src.txz

sudo tar xvf src.txz -C /

# COMPILE PORT =========================================================================================================
cd /usr/ports/emulators/virtualbox-ose
sudo make install clean



# FIX +X PERMISSON ON VIRTUALBOX EXECUTABLE ============================================================================
chmod +x /usr/local/lib/virtualbox/VirtualBox



# KERNEL MODULE ========================================================================================================
#https://www.freebsd.org/doc/handbook/virtualization-host-virtualbox.html
#A few configuration changes are needed before VirtualBox™ is started for the first time.
# The port installs a kernel module in /boot/modules which must be loaded into the running kernel:
kldload vboxdrv

#To ensure the module is always loaded after a reboot, add this line to /boot/loader.conf:
# vboxdrv_load="YES"
grep vboxdrv_load /boot/loader.conf  > /dev/null 2>&1  || echo 'vboxdrv_load="YES"' >> /boot/loader.conf



# NET KERNEL MODULE ====================================================================================================
# kernel modules that allow bridged or host-only networking, need this line in /etc/rc.conf. Reboot needed.
# vboxnet_enable="YES"
sysrc vboxnet_enable="YES"



# HOST NETWORK DEVICE PERMISSIONS ======================================================================================
# The default permissions for /dev/vboxnetctl are restrictive and need to be changed for bridged networking:
chown root:vboxusers /dev/vboxnetctl
chmod 0660 /dev/vboxnetctl

# To make this permissions change permanent, add these lines to /etc/devfs.conf:
bash -c 'grep "vboxnetctl root:vboxusers" /etc/devfs.conf  > /dev/null 2>&1  || printf "own     vboxnetctl root:vboxusers\nperm    vboxnetctl 0660\n\n" >> /etc/devfs.conf'



# DON'T FORGET TO ADD YOURSELF TO GROUP ================================================================================
printf  "\nThe vboxusers group is created during installation of VirtualBox™. All users that need access to VirtualBox™ \
 will have to be added as members of this group. pw can be used to add new members:\n"

pw groupmod vboxusers -m $USER
# you should reboot here

#BOOT UNDO
#unload module_name #vboxdrv
#disable-module module_name #vboxdrv
#boot
