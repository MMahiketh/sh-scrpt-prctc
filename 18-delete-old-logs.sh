#!/bin/bash

TARGET_DIR=$1
USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

#Check for correct no. of arguments
if [ $# -ne 1 ]
then
	echo -e "${R}USAGE::${Y} $0 <target-dir>${N}		Please pass the Target DIR as argument"
	exit 1
fi

#Check if the dir exists
if [ ! -d $TARGET_DIR ]
then
	echo -e "$TARGET_DIR ${R}not found${N}. Please check."
	exit 1
fi

#Check for root user
if [ $USERID -ne 0 ]
then
	echo -e "${R}Root user not detected.${N} Please run as root."
	exit 1
fi

FILES=$(find $TARGET_DIR -type f -name "*.log" -mtime +14)

#Check if any file found
if [ -z "$FILES" ]
then
	echo -e "No files found older than 14 days. No need to clean $TARGET_DIR"
else
	#Delete files
	echo "files need to be deleted are:"
	while IFS= read -r file
	do
		echo "$file"
		rm -vrf $file
	done <<< $FILES
fi

