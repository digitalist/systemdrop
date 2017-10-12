#@IgnoreInspection BashAddShebang
# Lumina is a Desktop Environment part of FreeBSD-based OS.
# It's written in C++ / QT, it's very fast and relatively easy as a traditional GUI DE

pkg install -y lumina
grep -q lumina ~/.xinitrc > /dev/null 2>&1 || echo "exec lumina-desktop" >> ~/.xinitrc
