#!/bin/bash
multitmux() {
	hosts=(10.1.0.1 10.1.0.2 10.1.0.3 10.1.0.4 10.1.0.6 10.1.0.7 10.1.0.9 10.1.0.10 10.1.0.12 10.1.0.27 10.1.0.200 10.1.0.201 10.1.0.202 10.1.0.203 10.1.0.204)
	tmux new-window "ping ${hosts[0]}"
	unset hosts[0]
	for i in "${hosts[@]}"; do
		tmux split-window -h "ping $i"
		tmux select-layout tiled > /dev/null
	done
	tmux set-option synchronize-panes
}
multitmux
