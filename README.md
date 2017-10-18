# Project SystemDrop
##### Linux  -> FreeBSD migration notes, 2017

##### 0. tl;dr: Running sum: 
- FreeBSD GUI programs crash a lot less than Ubuntu's.
- It feels faster (maybe because of Lumina)
- If you're like 'I wanna full userfriendly mode' - Try TrueOS. It's like (in a good way) Ubuntu of FreeBSD. 
These notes/scripts still can be useful if something goes wrong. 

## 1. Preface

You are reading a fall/winter 2017 year notes about my  attempt[currently] to migrage from Linux (Ubuntu 14/17) to FreeBSD 11. 

For about 5-6 years  Linux was my main OS on every home/office/computer/server system I worked with.

As a backend/web developer I have a relatively small and strict set of needs for my day-to-day working OS,
and the purpose of these notes is to document how I'm transferring my needs and habits (aka zone of comfort) from Linux to FreeBSD.

I do hope that FreeBSD will be much better for me in the long run, and while migrating your zone of comfort
is a great deal of PITA, it's fun. And, I hope, these notes will save someone some time googling / rebooting

`installs/` directory contains short scripts for basic install tasks. 
They should be harmless. 

For example: `sudo sh installs/java.sh` will install OpenJDK 8

## 2. Rationale
There are two main reasons to migrate from Linux to FreeBSD
1. SystemD: abomination-from-another-dimension, ever mutating monster. 
Monolithic piece of architectural nightmare that turned Linux into a horrible altar of stupidity. 
If you ever heard of KISS principle, failsafe system, loose coupling: it's not  about systemd

2. Six years is a long enough time to know Linux like a good friend. I don't need to have a linux desktop to avoid
context switching when working with servers. I want to try another flavour of OS. Another community, find something new and something better

3. clang/LLVM included!

- Small target: make everything as good as it was in Linux. 
- Ideal target: better than Linux (thanks, systemd it's an easy target now)

### Subtargets:
- Hardware: hardware GPUs, WiFi✔ , mobile/LTE ✔
- Network/devops: ssh✔, openvpn✔, git✔, python3✔, pyenv✔ / pipenv, c++✔/cmake✔, tmux✔, docker
- IDEs: PyCharm✔, CLion✔, QT Builder (visual GUI design)
- Small editors: atom/jedit✔, sublime, vscode, vim✔ 
- Gaming: emulators✔ with gamepad✔ (see `installs/gamepad.sh`) scummvm, dosbox
- Misc: torrents✔, virtualbox
- BSD: jails, bhyve(?), zfs

@todo: describe EVENT_01, add links to  

 
## 3. Installation notes
### Media:
If you're going to install from USB, download *memstick image*. If you encounter strange errors during install, check:
    
- Irrelevant to FreeBSD: Is your flash ok? I had to buy a new flash, because mine had some irreversible errors. 
- Relevant: It must a memstick image or unpacked memstick.xz, not DVD.iso

### First time console:
installs/basic_packages_console.sh

### Filesytems:
If you have enough time to read about it, choose ZFS. Choose UFS for experiments/recover/`fsck -yf`      
    
## 4. Basic differences from Linux
- Linux is not an OS, Linux distribution (i.e. Ubuntu) is OS.
- FreeBSD is OS. It has derivatives like TrueOS, friends like OpenBSD 
- Directory structure (/etc -> /usr/local/etc), `man hier`
- Default user shell is not bash (change for user: `chsh -s /usr/local/bin/bash`), avoid changing shell for root

### 4.1 Fixing usability issues:
By default Ubuntu allows bash autocompletion, like `git i[TAB]` `->` `git init`, or `ssh [TAB] lo`->`ssh localhost`, check 
 `installs/bash-completion.sh`  


### Basic commands

|Linux|FreeBSD|
|---|---|
|`yum` / `apt` / `rpm` |`pkg` / ports|
|`apt install -y vim`| `pkg install -y vim`|
|`synaptic`|`AppCafe` *|
|`lsb_release -a`|`freebsd-version`|

*from TrueOS

#### Links:
https://www.cyberciti.biz/tips/freebsd-display-information-about-the-system.html


#### Admin/diagnostic
    sysctl -a #aka linux procfs - https://www.freebsd.org/doc/en/articles/linux-users/procfs.html
   

### Packages/ports system 
FreeBSD has two (or more) modes of software distribution: 
- packages (linux: yum/apt)
- ports - building from source code ()see `installs/ports.sh`)


see `installs/basic_packages.sh` for tools I needed during migration and/or am using now. All of them exist in Linux-world too.

## 5. Graphics
### SCFB driver
If you can't get video working with nvidia/intel/amd: 
use vesa driver for BIOS, scfb driver for UEFI
see `installs/video_scfb.sh` for setting console/xorg high resolution 

## 6. Network
- WiFi: add WiFi networks without GUI: see `config/etc/wpa_supplicant.conf` and `intalls/wifi.sh`
- Start DHCP for USB-modem (Android phone, in my case) `dhclient ue0`, 
- OpenVPN: if you have client config files, see `installs/openvpn_client.sh`

IMPORTANT: if you have Intel laptop with Intel WiFi and use FreeBSD11
do not add `if_iwm_load="YES"` to rc.confi, it can cause KERNEL PANIC

## 7. Sound:
See `installs/misc/poor_hoomans_sound.sh` for managing soundcards through console/without soundserver

## 8. Xorg/GUI
- Localization
- Fonts
By default Firefox uses only 3 system fonts which leads to horrible results.  Fix this by opening 
`about:config` `->` `gfx.font_rendering.fontconfig.max_generic_substitutions` `:` `127`. Stumbled on a bug with
*.woff fonts, fixed with switching font settings in about:config / content preferences (allow pages to use own fonts)


#### Links:
- https://ramsdenj.com/2016/07/25/openvpn-on-freebsd-10_3.html#client-config
- http://www.freebsddiary.org/openvpn.php

## 9. Editors/Misc/Java
PyCharm/CLion/IntelliJ, other Java-based software: see `installs/java.sh`
- CLion need workaround: see `bugs/clion.2017.txt`
jedit / Horrible Java Fonts solution: setenv:  `_JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on` 

## 10. Unresolved Issues
- see `bugs/` directory 
- sshfs, see `installs/sshfs.sh`
- how to use ~/.login_conf and cap_mkdb? It's totally ignored!

## 11. Debug tools 
- *truss* is *strace* of FreeBSD. Example:
`truss sshfs -d -f user@example.com:/ ~/mnt/example.com 2>&1 | grep ERR`

- dtrace: kernel/userspace debugg tracing : 
https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/dtrace.html    

    
### Notes and links
http://adventurist.me/posts/028871
https://wiki.archlinux.org/index.php/Xorg_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
http://www.ivoras.net/blog/tree/2013-06-03.openvpn-on-freebsd.html