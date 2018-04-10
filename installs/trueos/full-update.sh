#!/usr/bin/env bash

cd /usr/src
sudo git pull

cd /usr/ports
sudo git pull

sudo pc-updatemanager pkgupdate
sudo pc-updatemanager startupdate
