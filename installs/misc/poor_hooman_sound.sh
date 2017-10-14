#@IgnoreInspection BashAddShebang

dmesg | grep pcm  #show sound devices
# example output
# pcm0: <Realtek ALC235 (Analog)> at nid 20 and 25 on hdaa0
# pcm1: <Realtek ALC235 (Front Analog Headphones)> at nid 33 on hdaa0
# pcm2: <Intel Skylake (HDMI/DP 8ch)> at nid 3 on hdaa1

# root/sudo to set default headphones:
sysctl hw.snd.default_unit=1

# root/sudo get back to laptop speakers:
sysctl hw.snd.default_unit=0

