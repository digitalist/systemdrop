#DO NOT LOAD if_iwm through rc.conf, it CAN CAUSE KERNEL PANIC
kldload if_iwm
service netif restart
#cp wpa_supplicant.conf /etc/
ifconfig wlan0 create wlandev iwm0

#wlans_iwm0="wlan0"                                                              
#ifconfig_wlan0="WPA SYNCDHCP"

