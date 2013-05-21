#!/bin/bash
ROUTE=`ip route show 192.168.178.0/24 dev fluxnet | wc -l`
if [ $ROUTE -eq 0 ]; then
	sudo route add -net 192.168.178.0 netmask 255.255.255.0 gw 10.1.0.12
	echo "Route an"
else
	sudo route del -net 192.168.178.0 netmask 255.255.255.0 gw 10.1.0.12
	echo "Route aus"
fi
