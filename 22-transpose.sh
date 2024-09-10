#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

FILE=$1
RES_FILE="${FILE}-TRANS"
rm -rf $RES_FILE

if [ ! -f $FILE ]
then
	echo -e "${R}USAGE::${N} $0 <file-name>"
	exit 1
fi

LNES=$(cat $FILE)

NO_COL=$(echo "$LNES"|awk -F " " 'NR==1{print NF}')

for i in $(eval echo {1..${NO_COL}})
do
	CLINE=$(echo "$LNES"|awk -F " " -v var=$i '{print $(var)F}')
	echo $CLINE &>> $RES_FILE
done
