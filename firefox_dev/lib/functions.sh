#!/bin/bash
function fetchNew() {
	cd versions/
	for i in "${firefox_version[@]}"; do
		#rm $prefix/*.tar.bz2 #cleanup
		installVersion $i
	done
}
function installVersion() {
	if [ ! -d "$prefix/firefox-$1" ]; then
		mkdir $prefix/firefox-$1
	fi
	if [ ! -x "$prefix/firefox-$1/firefox/firefox" ]; then
		wget https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$1/linux-x86_64/de/firefox-$1.tar.bz2
		tar xfj firefox-$1.tar.bz2 -C firefox-$1/
	else
		echo "Firefox: $1 ist bereits installiert."
	fi
}
function startFirefox() {
	if [ `firefoxVersionExists $1` ]; then
		$prefix/firefox-$1/firefox/firefox -new-instance -P clean
	fi
}
function firefoxVersionExists() {
	if [ -x "$prefix/firefox-$1/firefox/firefox" ]; then
		echo "ausführbar"
		return 0
	else
		for i in "${firefox_version[@]}"; do
			if [ $i == $1 ]; then
				cd versions/
				installVersion $i
				echo "installiert"
				return 0
			fi
		done
		return 1
	fi
}
function listVersions() {
	for i in "${firefox_version[@]}"; do
		if [ `firefoxVersionExists $i` ]; then
			echo -e "\033[1;32m Firefox $i installiert.\033[0m"
		else
			echo -e "\033[0;35m Firefox $i NICHT installiert.\033[0m"
		fi
	done
}
