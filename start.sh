#!/bin/bash
benutzer=(amboss dctmz neo proggi reaper roby techfreak kirschbluete)
for i in "${benutzer[@]}"; do
	su -c rtorrent.sh $i
done
