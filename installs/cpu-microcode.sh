#!/usr/bin/env bash
#enable microcodes update amd/intel cpu
pkg instal -y sysutils/devcpu-data
sysrc microcode_update_enable="YES"