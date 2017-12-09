#!/usr/bin/env bash
# curl -s http://www.srobb.net/jpninpt.html | md5 #053ffe9f4b4f359f45773b17f2f31665

# In FreeBSD-10, I've begun to use fcitx-mozc. (I mention my difficulties with ibus-mozc below.) I install it with portmaster.

portmaster japanese/fcitx-mozc

#With pkg it would be

pkg install ja-fcitx-mozc

#I install various fonts--the reader can choose their own, I usually install
# font-sazanami, font-kochi, font-vlgothic
# (all in /usr/ports/japanese) and
# x11-fonts/hanazono-fonts-ttf.
#
#If using pkg it's
pkg install -y ja-font-sazananmi, ja-font-kochi ja-font-vlgothic hanazono-fonts-ttf
#              ja-font-sazanami
#For fcitx to work, dbus must be running so make sure you have dbus_enable="YES" in /etc/rc.conf. One oddity I've found
# is that when one first starts fcitx, it may change your keyboard. Make sure you have setxkbmap installed
# (pkg install setxkbmap will do) so that you can run setxkbmap us to bring your keyboard back to a US one
# (if that's what you use.) If, as has happened to me, it happens while you're editing a file with vi, then the single
# quote key gives me a colon. I'm not sure what keyboard mapping it is, but if you're stuck in vi, and hitting colon
# gives you a plus sign, use the single quote key and you should be good. Then run setxkbmap us, or whatever your normal
# keyboard is. This hasn't been a consistent problem.
#
#Another oddity, is that on some installs, urxvt wouldn't show Japanese. It didn't give anything. I could hit ctl+space,
# characters would appear, but when I hit enter, the terminal stayed blank. I then reinstalled from ports
# (I'd installed with pkg the first time), it added in a few packages from Chinese, and then everything was fine.
# However, on another install from pkg, that definitely didn't have these Chinese packages installed, I didn't have that
# problem. I only mention it in case the reader has a similar issue--if urxvt isn't displaying Japanese, try
# reinstalling it from ports. If that still doesn't work, the other issue I've found is that it may not work if
# LC_CTYPE isn't specified. So, on some installs, I have had to insert
#

export LC_CTYPE=en_US.UTF-8

#to $HOME/.xinitrc, above the line calling the window manager.

#The message after installation, readable with pkg info -D -x fcitx-mozc, tells you to add variables and commands to
# start fcitx and mozc to your .xinitrc file (or .xession, if you use that.) It suggests adding

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=xim
export XMODIFIERS=@im=fcitx
/usr/local/bin/mozc start
fcitx -r -d

#In practice, I find that I don't need the mozc line. I also add, as mentioned above

export LC_CTYPE=en_US.UTF-8

#In another install, I was able to add the LC_CTYPE line to my .bashrc--but at least on one 10.2 install, it didn't
# work there, only seeming to have an effect (on the problem mentioned above, of urxvt not showing Japanese), if put
# into .xinitrc.

#Also, make sure that your window manager or desktop environment isn't using ctl+space for anything, as that is fcitx's
# default key combo to switch between Japanese and English. I've never tried to change it, but I believe you can do so
# in $HOME/.config/fcitx/conf.

#There is a separate port, chinese/fcitx-configtool. Install it with portmaster chinese/fcitx-configtool. Once it's
# installed run it.

#fcitx-configtool

#On the left it will show available input. Uncheck Only Show Current Language at the bottom. Once you do that, you'll
# see a bunch of languages in the left hand window. Click the little arrow to the left of Japanese. and at the bottom of
# the list that appears, you should see Mozc. Highlight it and then click the arrow pointing to the right window, and it
# should now appear under whatever language you're using. Hitting ctl+space should now allow you to input Japanese in
# applications that accept it.

#This can also be done manually. After starting fcitx the first time, you will have a $HOME/.config/fcitx/profile file.
# Kill X and then edit it. If using vi, as it has extremely long lines, you may just see about 10-20 lines then a
# bunch of @ symbols, but if you search with your text editor's search function, you'll find `mozc:False`

#This has to be changed to read `mozc:True`. Once this is done, you should be able to hit ctl+space in any application
# that will accept Japanese input, see a little box saying mozc, and be able to input Japanese.

#As mentioned, it seems to change my keyboard map, so, in my .xinitrc on FreeBSD, I start with a line to set my
# keyboard to us. Therefore, my $HOME/.xinitrc reads

#setxkbmap us

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=xim
export XMODIFIERS=@im=fcitx
fcitx -r -d

#exec dwm

#This doesn't always work for me, but if not, I can always run setxkbmap us once I've started X which will fix any issues.

#In FreeBSD-10 and 11.x, I'm finding another oddity. The fcitx-mozc works in everything but Firefox. It works in Thunderbird, Libreoffice, urxvt and everything else. I have in my .xinitrc

#export LC_CTYPE=en_US.UTF-8

#However to get Japanese working in Firefox I have to run

#LC_CTYPE=ja_JP.UTF-8 firefox

#and then Japanese input works. If this changes as packages get updated, I'll update it here. But for now, you can
# either use the LC_CTYPE=ja_JP mentioned above or use another browser. (Chromium and Opera work with Japanese withou
# t problem.)

#anthy
#export XIM=ibus
#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=xim
#export XMODIFIERS=@im=ibus
#export XIM_PROGRAM="ibus-daemon"
#export XIM_ARGS="-r --daemonize --xim"
