#!/bin/sh
# Schwanzvergleich powered by http://pinguinblog.de
export LC_ALL=C
echo `uptime|grep days|sed 's/.*up \([0-9]*\) day.*/\1\/10+/'; cat /proc/cpuinfo|grep '^cpu MHz'|awk '{print $4"/30 +";}';free|grep '^Mem'|awk '{print $3"/1024/3+"}'; df -P -k -x nfs -x smbfs | grep -v '(1k|1024)-blocks' | awk '{if ($1 ~ "/dev/(cciss|scsi|sd)"){ s+= $2} s+= $2;} END {print s/1024/50"/15+70";}'`|bc|sed 's/\(.$\)/.\1cm/'
