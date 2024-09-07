#!/bin/bash

AGE=$1

if [ $AGE -lt 18  ]
then
	echo "Your age is less than 18. Not allowed to vote."
elif [ $AGE -eq 18 ]
then
	echo "Congratulations on your first vote. You can vote."
else
	echo "Your age is greater than 18. You can vote."
fi
