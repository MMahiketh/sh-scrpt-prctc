#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

USERID=$(id -u)
TARGET_DIR=$1
DESTIN_DIR=$2
DAYS_OLD=${3: 14} #Takes +14 as default input, when 3rd argument is not passed

#Check for correct no. of arguments
if [ $# -lt 2 ] || [ $# -gt 3 ]
then
	echo -e "${R}USAGE::${Y} $0 <target-dir> <destin-dir> <no.-of-days-old(optional)> ${N}	Please check the argument and try again"
	exit 1
fi

#Check if the dir exists
if [ ! -d $TARGET_DIR ] && [ ! -d $DESTIN_DIR ]
then
	echo -e "$TARGET_DIR or $DESTIN_DIR :: ${R}not found${N}. Please check."
	exit 1
fi

#Check for root user
if [ $USERID -ne 0 ]
then
	echo -e "${R}Root user not detected.${N} Please run as root."
	exit 1
fi

cd $TARGET_DIR
FILES=$(find ./ -type f -name "*.log" -mtime +${DAYS_OLD})

#Check if any file found
if [ -z "$FILES" ]
then
	echo -e "${R}No files found${N} older than $DAYS_OLD days. No need to backup $TARGET_DIR"
else
	#Archiving and Deleting them
	zip -vm $DESTIN_FILE $FILES
	echo -e "Log files have been archived... ${G}SUCCESSFULLY${N}"
fi

