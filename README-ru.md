# Проект SystemDrop
##### заметки о миграции Linux -> FreeBSD, 2017

##### 0. tl;dr: итог в движении: 
- Гуевые программы на FreeBSD крашатся реже, чем на Убунте. 
- Ощущается как "быстрее" - не при загрузке, но зато это не systemd.

## 1. Preface 
Вы читаете мои заметки  - сезона осень/зима-2017  - о переезде с Linux (Ubuntu 14/17) на FreeBSD 11

5-6 лет Linux был моей основной (единственной на самом деле) рабочей системой на каждом компьютере с которым я работал,
будь то домашний стационарник, личный ноутбук, рабочий комп или какой-нибудь сервер. 

Как бэкэнд-веб-разработчик я имею небольшие но строгие требования к тому, что мне нужно от еженедневно работы с ОС и
цель этих заметок - задокументировать - как как я перенес эти требования и привычки (ака зона комфорта) с Linux на FreeBSD

Я надеюсь, что FreeBSD будет для меня удобней, и хотя миграция зоны комфорта - это та еще боль в жопе - это весело. Ну и, надеюсь
эти заметки сэкономят кому-то пачку ребутов и несколько сеансов гугления

директория `installs/` содержит небольшие скрипты с простыми установочными действиями. Они вроде безвредны. Чтобы не превращать этот README
в огромную документацию, часть текста я слил прямо в комментарии этих скриптов.

К примеру: `sudo sh installs/java.sh` установит OpenJDK 8

## 2. Rationale
Для меня есть две основные причины мигрировать на FreeBSD:
1. SystemD:  выродок-из-другого-измерения. Вечно мутирующий монстр.  
Монолитный кусок архитректурного кошмара, который превратил Linux  в храм поклонения идиотизму и невежеству. 
Если вы когда-нибудь слышали о принципе KISS, отказоусточивых системах, слабой связанности: это не про systemd 
2. Шесть лет - достаточно долгий срок чтобы подружиться с Linux, с недавних пор мне ненужен рабочий Linux-десктом чтобы избежать 
переключений ментального контекста, когда я работаю с серверами. Я хочу попробовать другкю разновидность ОС, другое соообщество, 
найти что-то новое, что-то лучше. 

- Мини-цель: сделать всю рабочую среду такой же удобной, как в Linux 
- Идеальня цель: лучше чем Linux - благодарим systemd - это очень легко.

### Subtargets:
- Железо: железные GPUs, WiFi✔ , mobile/LTE ✔
- Сеть/devops: ssh✔, openvpn✔, docker, git✔, python3✔, pyenv/pipenv, c++✔/cmake✔
- IDEs: PyCharm✔, CLion✔, QT (for visual gui design)
- Подручные редакторы: atom/jedit✔,sublime, vscode, vim✔ 
- Про поиграть: эмуляторы✔ с геймпадом✔ (см. `installs/gamepad.sh`)
 
@todo: describe EVENT_01, add links to  

 
## 3. Installation notes
### Media:
Если вы устанавливаете с USB, качайте *memstick image*, при обнаружении странных ошибок во время установки, проверьте:
    
- Неотносящееся к FreeBSD: Is your flash ok? I had to buy a new flash, because mine had some irreversible errors. 
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

- Linux: `yum` / `apt` ... etc 
- FreeBSD: `pkg`, ports,

- Linux: `synaptic` / Ubuntu Software center
- FreeBSD: `AppCafe`

- Ubuntu: `apt install -y vim`
- FreeBSD: `pkg install -y vim`

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

## 6. Xorg/GUI
- Localization
- Fonts

## 7. Network
- WiFi: add WiFi networks without GUI: see `config/etc/wpa_supplicant.conf` and `intalls/wifi.sh`
- Start DHCP for USB-modem (Android phone, in my case) `dhclient ue0`, 
- OpenVPN: if you have client config files, see `installs/openvpn_client.sh`

IMPORTANT: if you have Intel laptop with Intel WiFi and use FreeBSD11
do not add `if_iwm_load="YES"` to rc.confi, it can cause KERNEL PANIC

#### Links:
- https://ramsdenj.com/2016/07/25/openvpn-on-freebsd-10_3.html#client-config
- http://www.freebsddiary.org/openvpn.php

## 8. Editors/Misc/Java
PyCharm/CLion/IntelliJ, other Java-based software: see `installs/java.sh`
- CLion need workaround: see `bugs/clion.2017.txt`
jedit / Horrible Java Fonts solution: setenv:  `_JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on` 

## 9. Unresolved Issues
- see `bugs/` directory 
- sshfs, see `installs/sshfs.sh`
- how to use ~/.login_conf and cap_mkdb? It's totally ignored!

## 10. Debug tools 
- *truss* is *strace* of FreeBSD. Example:
`truss sshfs -d -f user@example.com:/ ~/mnt/example.com 2>&1 | grep ERR`

- dtrace: kernel/userspace debugg tracing : 
https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/dtrace.html    

    
### Notes and links
http://adventurist.me/posts/028871
https://wiki.archlinux.org/index.php/Xorg_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
http://www.ivoras.net/blog/tree/2013-06-03.openvpn-on-freebsd.html