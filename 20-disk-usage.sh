#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

DISK_USAGE=$(df -hT|grep "xfs"|awk -F " " '{print $NF,$(NF-1)}')
DISK_THRESHOLD=5

while IFS= read -r disks
do
	DISK=$(echo $disks|cut -d " " -f1)
	USED=$(echo $disks|cut -d " " -f2)
	
	if [ $USED -gt $DISK_THRESHOLD ]
	then
		echo "$DISK is more than ${DISK_THRESHOLD}%. Current usages is ${USED}%"
	fi
done <<< $DISK_USAGE
