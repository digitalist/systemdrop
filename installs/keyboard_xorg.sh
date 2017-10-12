#@IgnoreInspection BashAddShebang
#swtich language with capslock
grep  -q -F microsoft ~/.xinitrc > /dev/null 2>&1  ||  echo 'setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps,numpad:microsoft"' > ~/.xinitrc



