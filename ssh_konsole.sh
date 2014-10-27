#!/bin/bash
if [[ -z $KONSOLE_DBUS_WINDOW ]]; then
	echo "Kann das Fenster nicht finden :("
else
	machines=(10.1.0.1 10.1.0.2 10.1.0.3 10.1.0.4 10.1.0.6 10.1.0.9 10.1.0.15 10.1.0.27 10.1.0.200 10.1.0.201 10.1.0.202 10.1.0.203 10.1.0.204)
	for host in ${machines[@]}; do
		sess=`qdbus $KONSOLE_DBUS_SERVICE $KONSOLE_DBUS_WINDOW org.kde.konsole.Window.newSession`
		qdbus $KONSOLE_DBUS_SERVICE /Sessions/$sess org.kde.konsole.Session.runCommand "ssh root@$host" 2>&1
	done
fi
