#!/bin/bash
STATE=$( cat /sys/devices/platform/thinkpad_acpi/bluetooth_enable )
if [[ $STATE -eq 1 ]];then
	if [[ $UID -eq 0 ]];then
		echo 0 >> /sys/devices/platform/thinkpad_acpi/bluetooth_enable
	else
		su -c "echo 0 >> /sys/devices/platform/thinkpad_acpi/bluetooth_enable"
	fi
else
	if [[ $UID -eq 0 ]];then
		echo 1 >> /sys/devices/platform/thinkpad_acpi/bluetooth_enable
	else
		su -c "echo 1 >> /sys/devices/platform/thinkpad_acpi/bluetooth_enable"
	fi
fi
