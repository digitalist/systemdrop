#!/usr/bin/env bash
# Let's try to create a common, useful with defaults setup here:
# don't try this at home, until this notice disappears contains things relevant to my setup
# some content will go to other scripts
# 1 zfs:
sysrc zfs_enable="YES"
service zfs start

# @local
zpool create example /dev/ada0 #let's create pool with a wrong name
#renaming a pool: from https://www.itfromallangles.com/2014/06/adventures-in-zfs-rename-a-zpool/
zpool export example #we need export it, to rename
zpool import example hdd-ada #we import it with a new name

#sudo zfs create hdd-ada/data


# 2
# In order to use the File System read/write monitor, you must chmod
# /dev/devstat so that all users can open it read-only.  For example:

# chmod 0444 /dev/devstat

# In order for this to persist across reboots, add the following to
# /etc/devfs.conf:
#perm    devstat 0444
grep "perm    devstat 0444" /etc/devfs.conf >>/dev/null || echo "perm    devstat 0444" >> /etc/devfs.conf


# docker-machine =======================================================================================================
pkg install -y docker-machine docker-17.06.1
sysrc -f /etc/rc.conf docker_enable="YES"


docker-machine  create test
#    Creating CA: /home/user/.docker/machine/certs/ca.pem
#    Creating client certificate: /home/user/.docker/machine/certs/cert.pem
#    Running pre-create checks...
#    (test) Image cache directory does not exist, creating it at /home/user/.docker/machine/cache...
#    (test) No default Boot2Docker ISO found locally, downloading the latest release...
#    (test) Latest release for github.com/boot2docker/boot2docker is v17.10.0-ce
#    (test) Downloading /home/user/.docker/machine/cache/boot2docker.iso from https://github.com/boot2docker/boot2docker/releases/download/v17.10.0-ce/boot2docker.iso...
#    (test) 0%....10%....20%....30%....40%....50%....60%....70%....80%....90%....100%
#    Creating machine...
#    (test) Copying /home/user/.docker/machine/cache/boot2docker.iso to /home/user/.docker/machine/machines/test/boot2docker.iso...
#    (test) Creating VirtualBox VM...
#    (test) Creating SSH key...
#    (test) Starting the VM...
#    (test) Check network to re-create if needed...
#    (test) Found a new host-only adapter: "vboxnet0"
#    (test) Waiting for an IP...
#    Waiting for machine to be running, this may take a few minutes...
#    Detecting operating system of created instance...
#    Waiting for SSH to be available...
#    Detecting the provisioner...
#    Provisioning with boot2docker...
#    Copying certs to the local machine directory...
#    Copying certs to the remote machine...
#    Setting Docker configuration on the remote daemon...
#    Checking connection to Docker...
#    Docker is up and running!
#    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env test


docker-machine env test

#    export DOCKER_TLS_VERIFY="1"
#    export DOCKER_HOST="tcp://192.168.99.100:2376"
#    export DOCKER_CERT_PATH="/home/user/.docker/machine/machines/test"
#    export DOCKER_MACHINE_NAME="test"
#    # Run this command to configure your shell:
#    # eval $(docker-machine env test)

docker-machine active
docker-machine stop test


# docker-machine =======================================================================================================
# service docker start

