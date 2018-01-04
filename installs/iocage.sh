#!/usr/bin/env bash
# sudo here
# maybe you should run `sudo sh iocage-jails-networking.sh` before proceeding further
sudo pkg install py36-iocage
#if ls -all rc.conf.trueos
# rc-update add iocage default
#else:
sysrc iocage_enable="YES"
sudo zfs create hdd-ada/iocage
iocage activate hdd-ada # activate zpool by name

# sudo zfs allow user allow hdd-ada/iocage #idk if needed, or how to use iocage without root
iocage fetch # choose & install FreeBSD release for the jail


# from docs: http://iocage.readthedocs.io/en/latest/basic-use.html#activate-iocage
# If a specific RELEASE is required, use the -r option:
# iocage fetch -r [11.1-RELEASE]

#cddeckard is a codename from https://namingschemes.com/Blade_Runner
sudo iocage create -r 11.1-RELEASE --name deckard # boot=on
#sudo iocage set owner=user deckard


# https://dan.langille.org/2015/03/07/getting-started-with-iocage-for-jails-on-freebsd/
# iocage set boot=on deckard
# iocage chroot deckard #chroot there for editing files

# show vnet status
sudo  iocage get vnet deckard
# iocage set vnet=off deckard


# network setup links:
# https://stevendouglas.me/?p=18 # nat iocage
# http://shawndebnath.com/articles/2016/03/27/freebsd-jails-with-vlan-howto.html # jails networking with vlan howto
# https://www.meschnet.de/2015/06/19/using-iocage/ :
    # iocage create tag=dns.meschnet.de ip4_addr="bge0|192.168.2.60" defaultrouter=192.168.2.1 allow_sysvipc=1 allow_raw_sockets=1
    # Replace meschnet.de with your domain, bge0 with your network interface and 192.168.2.60 with a free IP in your
    # network (the IP adress you wish that the jail should have). Also set the defaultrouter option to the IP address of your router.


sudo iocage set ip4_addr="wlan0|192.168.3.1" defaultrouter="192.168.0.1" deckard #wlan0
# sudo iocage set ip4_addr="DEFAULT|192.168.0.117/24" defaultrouter="" deckard #wlan0
#one/all of them of this allows you to network properly (ping, resolve etc)
sudo iocage set sysvmsg=inherit deckard # this
sudo iocage set sysvsem=inherit deckard # or this
sudo iocage set sysvshm=inherit deckard # allow shared memory usage from host

sudo iocage exec deckard "ping google.com"


# important: if there's a wrong interface, iocage will not allow you to stop/restart the jail, do:
# sudo iocage set ip4_addr="" deckard

sudo iocage stop deckard
# don't forget to allow sockets for particular jail during creation or like this:
sudo iocage set "allow_raw_sockets=1" deckard
sudo iocage start deckard

sudo iocage exec deckard ifconfig

#sudo iocage console deckard

