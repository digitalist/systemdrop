#!/usr/bin/env bash
# sudo here


sudo zfs create hdd-ada/iocage
iocage activate hdd-ada # activate zpool

# sudo zfs allow user allow hdd-ada/iocage #idk if needed, or how to use iocage without root
iocage fetch #get & install FreeBSD release for the jail