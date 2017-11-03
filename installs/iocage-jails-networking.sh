#!/usr/bin/env bash

# adapted from https://www.meschnet.de/2015/06/19/using-iocage/
grep  -q -F "security.jail.sysvipc_allowed=1" /etc/sysctl.conf > /dev/null 2>&1  ||  echo "security.jail.sysvipc_allowed=1" >> /etc/sysctl.conf
grep  -q -F "security.jail.allow_raw_sockets=1" /etc/sysctl.conf > /dev/null 2>&1  ||  echo "security.jail.allow_raw_sockets=1" >> /etc/sysctl.conf


# override jail network security settings on the host
sysctl security.jail.sysvipc_allowed=1
sysctl security.jail.allow_raw_sockets=1

# don't forget to allow sockets for particular jail during creation or like this:
# iocage set "allow_raw_sockets=1" deckard

