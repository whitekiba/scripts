#!/bin/bash
usr_group=`id -gn`
userid=`id -u`

#dont run motd if not a valid user. root or uid > 10000
if [ $userid -lt 10000 ] && [ $userid != 0 ]; then
	return
fi

grp_desc="Huh? Keine Gruppe?"
groups=`groups`
if [[ $groups == *Benutzer* ]]; then
	grp_desc="Normaler Benutzer"
fi
if [[ $groups == *NetAdmin* ]]; then
	grp_desc="NetAdmin. Du darfst etwas mehr."
	usr_group="NetAdmin"
fi
if [[ $groups == *Admin* ]]; then
	grp_desc="Admin! Hui! Du darfst fast alles."
	usr_group="Admin"
fi
if [[ $(whoami) == "whitekiba" ]]; then
	grp_desc="Das Alpha und das Omega!"
fi
session_limit=`cat /etc/security/limits.conf | grep "$usr_group" | grep maxlogins | awk {'print $4'}`

function mk_human() {
	val=`awk "BEGIN{sum=$1;
	hum[1024**3]=\"Gb\";hum[1024**2]=\"Mb\";hum[1024]=\"Kb\"; 
	for (x=1024**3; x>=1024; x/=1024){ 
		if (sum>=x) { printf \"%.2f %s\\n\",sum/x,hum[x];break }
	}}"`
	echo $val
}

function get_memlimit() {
	l_val=0
	if [[ -e "/sys/fs/cgroup/memory/user.slice/user-$userid.slice/memory.limit_in_bytes" ]]; then
		l_val=`cat /sys/fs/cgroup/memory/user.slice/user-$userid.slice/memory.limit_in_bytes`
	fi
	if [[ $l_val != 0 ]]; then
		limit=`mk_human $l_val`
		echo $limit
	else
		echo "Unbegrenzt"
	fi
}

echo -e "\033[1;32m  _____ _                       _   
 |  ___| |_   ___  ___ __   ___| |_ 
 | |_  | | | | \ \/ / '_ \ / _ \ __|
 |  _| | | |_| |>  <| | | |  __/ |_ 
 |_|   |_|\__,_/_/\_\_| |_|\___|\__|
\033[0m
\033[0;35m++++++++++++++:\033[0;37m Server Info \033[0;35m:+++++++++++++
\033[0;35m+ \033[0;37mHostname     = `hostname`
\033[0;35m+ \033[0;37mIP (public)  = 188.40.88.39
\033[0;35m+ \033[0;37mIP (VPN)     = 10.1.0.3
\033[0;35m+ \033[0;37mKernel       = `uname -r`
\033[0;35m+ \033[0;37mUptime       = `uptime -p`
\033[0;35m+ \033[0;37mLoad         = `cat /proc/loadavg | awk {'print $1'}`
\033[0;35m++++++++++++++:\033[0;37m User Info \033[0;35m:+++++++++++++++
\033[0;35m+ \033[0;37mUsername     = `whoami`
\033[0;35m+ \033[0;37mGruppe       = `id -gn` - $grp_desc
\033[0;35m+ \033[0;37mSessionlimit = `who | grep $USER | wc -l` von $session_limit
\033[0;35m+ \033[0;37mSpeicher     = Limit: `get_memlimit`
\033[0;35m++++++++++++++:\033[0;37m Notes \033[0;35m:+++++++++++++++++++"
if [[ $(who | grep root | wc -l) -gt 0 ]]; then
	echo -e "\033[0;35m+ - \033[1;31mroot ist online.\033[0m"
fi
echo -e "\033[0;35m+\033[0m - Proxy: proxy.ca.fluxnet.vpn:3128"
if [[ -e /etc/motd-notes ]]; then
	while read line
	do
		echo -e "\033[0;35m+ \033[0m- $line"
	done < /etc/motd-notes
fi

echo -e "\033[0;35m++++++++++++++:\033[0;37m motd v0.5.2 \033[0;35m:+++++++++++++++\033[0m"
