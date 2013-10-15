#!/bin/bash
IP=$(/bin/ip route | awk '/default/ { print $3 }')
if [ '$IP' == '10.1.0.4' ]; then #sollte unser gw im vpn sein deaktivieren wir
	CUR_GW=$(/bin/ip route | awk '/188.40.88.20/ { print $3 }')
	sudo route del default gw 10.1.0.4
	sudo route del -net 188.40.88.20 netmask 255.255.255.255 gw $CUR_GW
	sudo route add default gw $CUR_GW
else #wenn nicht aktivieren wir
	sudo ifconfig eth0 netmask 255.255.255.255
	sudo route add -net $IP netmask 255.255.255.255 dev eth0
	sudo route add -net 188.40.88.20 netmask 255.255.255.255 gw $IP
	sudo tincd -n fluxnet
	sudo route add default gw 10.1.0.4
fi
