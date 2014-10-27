#!/bin/bash
wee_log=~/.weechat/logs/
if [[ -z "$1" ]]; then #wir gehen nur in den Ordner
	cd $wee_log
else
	f_count=`ls -1t $wee_log | grep $1 | wc -l`
	if [[ $f_count -gt 1 ]]; then #es wurden mehrere Dateien gefunden. Liste ausgeben
		f_array=($(ls -1t $wee_log | grep $1))
		num=0
		for i in "${f_array[@]}"; do
			echo $num: $i
			num=$(($num+1))
		done
		echo "---"
		echo "Welche Datei willst du?"
		read f_num
		if [[ -n "${f_array[$f_num]}" ]]; then
			f_name=${f_array[$f_num]}
		else
			echo Die Datei kenn ich nicht :P
		fi
	else
		f_name=`ls -1t $wee_log | grep -m 1 $1` #da wir nur eine datei haben nehmen wir die direkt
	fi
	#ausgabe
	if [[ -n "$f_name" ]]; then
		echo $f_name
		tail -n200 $wee_log$f_name
	fi
fi
