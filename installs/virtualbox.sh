#!/usr/bin/env bash
# run under sudo!
# you MUST install ports (see installs/ports.sh) or freebsd handbook
ls /usr/ports/emulators/virtualbox-ose > /dev/null 2>&1 || printf "\n\n\nNO PORTS TREE  FOUND\n see installs/ports.sh\n\n\n"

# @todo: update documentation at https://www.freebsd.org/doc/handbook/virtualization-host-virtualbox.html
# if you forgot to install 32 bit libraries, running `make install clean` in  `/usr/ports/emulators/virtualbox-ose`
# will throw an error,
# solution by @freesbsd.forum:kpa from https://forums.freebsd.org/threads/45878/reply?quote=256635
# Extract the lib32.txz tarball from the distribution sets (should be at /usr/freebsd-dist on the installation media)
# at the root directory and that should be all.
#ldconfig -32 /usr/lib32/ /usr/local/lib32/compat/

# let's get that package from http mirror:
#http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/11.1-RELEASE/lib32.txz

VERSION=$(freebsd-version | egrep -o "[0-9.]+-[A-Z]+")
ARCH=$(uname -m)

function fix_permissions_and_flags(){
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


# curl those libs from mirror (ftp is evil)
printf "\n processing libs32.txz"
ls lib32.txz > /dev/null 2>&1 || curl -O http://ftp.freebsd.org/pub/FreeBSD/releases/$ARCH/$VERSION/lib32.txz
## RISKY BUSINESS: let's extract that tar to / root

fix_permissions_and_flags lib32.txz
#sudo tar xvf lib32.txz -C / && rm lib32.txz || printf "\n\n\nError extracting file. HOW ABOUT A CUP OF ... sudo?\n\n\n"
sudo tar xvf lib32.txz -C /  || printf "\n\n\nError extracting file. HOW ABOUT A CUP OF ... sudo?\n\n\n"

# @freesbsd.forum:SirDice says we must use ldconfig: https://forums.freebsd.org/threads/45878/reply?quote=256773
ldconfig -32 /usr/lib32/ # /usr/local/lib32/compat/

## We also need kernel sources: http://blog.ataboydesign.com/2014/03/17/freebsd-installing-virtualbox-no-rule-to-make-target-syskernbus_if-m-compile-error/
printf "\n processing src.txz"
ls src.txz > /dev/null 2>&1 || curl -O http://ftp.freebsd.org/pub/FreeBSD/releases/$ARCH/$VERSION/src.txz

sudo tar xvf src.txz -C /

#
cd /usr/ports/emulators/virtualbox-ose
sudo make install clean
chmod +x /usr/local/lib/virtualbox/VirtualBox
# ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/10.0-RELEASE/src.txz