# Проект SystemDrop
##### заметки о миграции Linux -> FreeBSD, 2017

##### 0. tl;dr: итог в движении: 
- Гуевые программы на FreeBSD крашатся реже, чем на Убунте. 
- Ощущается как "быстрее" - не при загрузке, но зато это не systemd.

## 1. Вступление 
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

## 2. Но зачеееееем
Для меня есть две основные причины мигрировать на FreeBSD:
1. SystemD:  выродок-из-другого-измерения. Вечно мутирующий монстр.  
Монолитный кусок архитректурного кошмара, который превратил Linux  в храм поклонения идиотизму и невежеству. 
Если вы когда-нибудь слышали о принципе KISS, отказоусточивых системах, слабой связанности: это не про systemd 
2. Шесть лет - достаточно долгий срок чтобы подружиться с Linux, с недавних пор мне ненужен рабочий Linux-десктом чтобы избежать 
переключений ментального контекста, когда я работаю с серверами. Я хочу попробовать другкю разновидность ОС, другое соообщество, 
найти что-то новое, что-то лучше. 
3. clang/llvm из коробки

### Цели
- Мини-цель: сделать всю рабочую среду такой же удобной, как в Linux 
- Идеальня цель: лучше чем Linux - благодарим systemd - это очень легко.

### Подцели:
- Железо: железные GPUs, WiFi✔ , mobile/LTE ✔
- Сеть/devops: ssh✔, openvpn✔, docker, git✔, python3✔, pyenv/pipenv, c++✔/cmake✔
- IDEs: PyCharm✔, CLion✔, QT (for visual gui design)
- Подручные редакторы: atom/jedit✔,sublime, vscode, vim✔ 
- Про поиграть: эмуляторы✔ с геймпадом✔ (см. `installs/gamepad.sh`)
 
@todo: describe EVENT_01, add links to  

 
## 3. Установка 
### Media:
Если вы устанавливаете с USB, качайте *memstick image*, при обнаружении странных ошибок во время установки, проверьте:
    
- Неотносящееся к FreeBSD: рэндомные ошибки могут быть признаком подыхающей флэшки, столкнулся с этим
- Относящееся: It must a memstick image or unpacked memstick.xz, not DVD.iso

### Консоль для начинающих
смотри `installs/basic_packages_console.sh`

### Файловые системы:
Если есть вермя разобраться, выбирайте ZFS. Иначе берите UFS и запомните команду `fsck -yf`      
    
## 4. Basic differences from Linux
- Linux - не ОС, дистрибутив Linux - например - Ubuntu/SuSE) - ОС.
- FreeBSD - ОС. У нее есть производные ОС - TrueOS, или  братские - например, OpenBSD 
- Слегка различается структура каталогов (/etc -> /usr/local/etc), `man hier`
- Дефолтный шелл  - не bash (сменить для пользователя: `chsh -s /usr/local/bin/bash`), не меняйте шелл для рута

### 4.1 Чиним юзабилити:
По дефолту Ubuntu включает автодополнение команд bash (и дополнительно ssh), тиипа `git i[TAB]` `->` `git init`, 
или `ssh [TAB] lo`->`ssh localhost`, смотри:  `installs/bash-completion.sh`  


### Различия в простых командах

- Linux: `yum` / `apt` ... и т.д.
- FreeBSD: `pkg`, ports,

- Linux: `synaptic` / Ubuntu Software center
- FreeBSD: `AppCafe`

- Ubuntu: `apt install -y vim`
- FreeBSD: `pkg install -y vim`

### Пакеты/порты 
FreeBSD поддерживает как минимум два (а то и больше) режима распространения и установки софта: 
- пакеты (как linux-овые: yum/apt)
- порты - построение из исходного кода смотри (`installs/ports.sh`). 

Смотри `installs/basic_packages.sh` - там программы, которые я использовал (использую и сейчас) при миграции. 
Все они существуют и в Linux-мире.

## 5. Графика
### SCFB драйвер
Если у вас не заводятся драйверы nvidia/intel/amd: 
используйте vesa driver если загружаетесь в BIOS-режиме, scfb driver в режиме UEFI,
см. `installs/video_scfb.sh` про выставление  разрешения для консоли/xorg   

## 6. Xorg/GUI
- @todo: локализация
жуткие шрифты в дефолтном Firefox лечатся так: `about:config`, `gfx.font_rendering.fontconfig.max_generic_substitutions=127`.
Кроме того, попался баг, когда Firefox не подгружает .woff шрифты - передернуть галочку в about:config или настройках
контента.
- включить сглаживание шрифтов в Java - см ниже в `Редакторы/Разное/Java`

## 7. Сеть
- WiFi: добавление WiFi сетей без GUI (с GUI я просто не смотрел): см `config/etc/wpa_supplicant.conf` и `intalls/wifi.sh`
- Запуск DHCP для USB-модема (Android телефон в моем случае) `dhclient ue0`, 
- OpenVPN: если есть файлы конфигурации клиента, смотри `installs/openvpn_client.sh`

ВАЖНО: на ноутбуках с intel-чипсетами и с Intel WiFi-железом  и FreeBSD11
не добавляйте `if_iwm_load="YES"` в rc.config может бросить ядро в панику

#### Ссылки:
- https://ramsdenj.com/2016/07/25/openvpn-on-freebsd-10_3.html#client-config
- http://www.freebsddiary.org/openvpn.php

## 8. `Редакторы/Разное/Java`
PyCharm/CLion/IntelliJ  и ваще Java-based software: see `installs/java.sh` 
- CLion нужен костылек, иначе подвисает процесс компиляции: see `bugs/clion.2017.txt`
jedit / ужасные шрифты в Java: выставить переменную  `_JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on` 

## 9. Нерешенные проблемы и @todo
- см `bugs/` directory 
- sshfs -`installs/sshfs.sh`
- how to use ~/.login_conf and cap_mkdb? It's totally ignored! Кажется, срабатывает после ребута, а не после разлогинивания. Проверить.

## 10. Инструменты отладки 
- *truss* это *strace*  от FreeBSD. Пример:
`truss sshfs -d -f user@example.com:/ ~/mnt/example.com 2>&1 | grep ERR`

- dtrace: kernel/userspace debugg tracing : 
https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/dtrace.html    

    
### Notes and links
http://adventurist.me/posts/028871
https://wiki.archlinux.org/index.php/Xorg_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
http://www.ivoras.net/blog/tree/2013-06-03.openvpn-on-freebsd.html