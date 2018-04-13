#!/usr/bin/env bash


# set SSD power consumption
sudo nvmecontrol power -p 2 nvme0

# you need to install powerd and add powerd_enable="YES" to /etc/rc.conf


# this is needed for gpu script
sudo kldload acpi_ibm
sudo kldload acpi_call

# you need to
# fetch https://people.freebsd.org/~xmj/turn_off_gpu.sh
# and place it somewhere
# taken from https://wiki.freebsd.org/TuningPowerConsumption

sudo bash /home/user/bin/turn_off_gpu.sh
