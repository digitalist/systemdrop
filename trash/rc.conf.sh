echo 'ifconfig_ue0="DHCP"' >> /etc/rc.conf
echo 'linux_enable="YES"' >> /etc/rc.conf
echo 'sysrc kld_list+="nvidia-modeset"' >> /etc/rc.conf