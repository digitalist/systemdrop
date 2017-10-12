#@IgnoreInspection BashAddShebang
#!/usr/bin/env sh
mkdir -p /usr/local/etc/openvpn && cd /usr/local/etc/openvpn
# place these files into /usr/local/etc/openvpn:
# cp client.conf /usr/local/etc/openvpn,
# client.crt /usr/local/etc/openvpn,
# client.key /usr/local/etc/openvpn
# #rename client.conf -> openvpn.conf:
# mv /usr/local/etc/openvpn/openvpn.conf
sysrc openvpn_enable="YES"
sysrc openvpn_if="tun"
