#!/bin/bash
cryptsetup luksOpen /dev/data/lv1 data
mount /dev/mapper/data /data/
./start.sh
