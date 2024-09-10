#!/bin/bash

FILE=$1

if [ ! -f $FILE ]
then
        echo -e "${R}USAGE::${N} $0 <file-name>"
        exit 1
fi

RES_FILE="${FILE}-RES"

TEXT=$(cat $FILE)

# Split into words, sort, and count unique occurrences
RES=$(echo "$TEXT"|tr '[:upper:]' '[:lower:]'|tr -s '[:space:]' '\n'|sort|uniq -c|sort -r)

echo "$RES" > $RES_FILE
