#!/usr/bin/env bash
# @todo: update documentation at https://www.freebsd.org/doc/handbook/virtualization-host-virtualbox.html
# if you forgot to install 32 bit libraries, running `make install clean` in  `/usr/ports/emulators/virtualbox-ose`
# will throw an error,
# solution by @kpa from https://forums.freebsd.org/threads/45878/reply?quote=256635
# Extract the lib32.txz tarball from the distribution sets (should be at /usr/freebsd-dist on the installation media)
# at the root directory and that should be all.
#ldconfig -32 /usr/lib32/ /usr/local/lib32/compat/