#!/bin/bash
fluxnet=(10.1.0.1 10.1.0.2 10.1.0.3 10.1.0.4 10.1.0.6 10.1.0.9 10.1.0.10 10.1.0.27)
cac=(10.1.0.200 10.1.0.201 10.1.0.202 10.1.0.203 10.1.0.204)
if [ -z $1 ]; then #kein parameter
	hosts=(${fluxnet[@]} ${cac[@]}) #zusammenfassen
else
	#in dem fall haben wir nen parameter
	if [ "$1" == "-set" ]; then
		case $2 in
			fluxnet)
				hosts=(${fluxnet[@]})
				;;
			cac)
				hosts=(${cac[@]})
				;;
			*)
				echo "Unbekanntes Set!"
				exit 0
				;;
		esac
	else
		echo "Unbekannter Parameter. Versuche -set <set>"
		exit 0
	fi
fi
multitmux() {
	tmux new-window "ssh root@${hosts[0]}"
	unset hosts[0]
	for i in "${hosts[@]}"; do
		tmux split-window -h "ssh root@$i"
		tmux select-layout tiled > /dev/null
	done
	tmux set-option synchronize-panes
}
multitmux
