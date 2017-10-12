#@IgnoreInspection BashAddShebang
# swtich language with capslock
# investigate: fcitx https://github.com/trueos/lumina/issues/149
grep  -q -F microsoft ~/.xinitrc > /dev/null 2>&1  ||  echo 'setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps,numpad:microsoft"' >> ~/.xinitrc



