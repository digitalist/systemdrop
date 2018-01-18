#!/usr/bin/env bash
sudo pc-updatemanager pkgupdate
sudo pc-updatemanager startupdate

cd /usr/src
sudo git pull

cd /usr/ports
sudo git pull

