#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

DISK_USAGE=$(df -hT|grep "xfs"|awk -F " " '{print $(NF-1),$NF}'|cut -d "%" -f1) 
DISK_THRESHOLD=5

while IFS= read -r disks
do
	DISK=$($disks|cut -d " " -f2)
	USED=$($disks|cut -d " " -f1)
	echo "disk is $DISK and used is $USED"
	if [ $($disks|cut -d " " -f1) -ge $DISK_THRESHOLD ]
	then
		echo "$($disks|cut -d " " -f2) is more than ${DISK_THRESHOLD}%. Current usages is $($disks|cut -d " " -f1)%"
	fi
	#echo "$($disks|cut -d " " -f2)"
done <<< $DISK_USAGE
