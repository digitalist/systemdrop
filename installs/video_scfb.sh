#@IgnoreInspection BashAddShebang
# manual way of setting video-mode for scfb console / xorg:
# type 3 during boot time (boot prompt)
# gop mode
# gop set #mode_number#
# automatic way

grep "gop set 0" /boot/loader.rc.conf  > /dev/null 2>&1  ||  echo "gop set 0" >> /boot/loader.rc.local