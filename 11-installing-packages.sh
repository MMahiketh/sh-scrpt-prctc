#!/bin/bash

#check if current user is root user

USER_ID=$(id -u)

echo "$USER_ID"

if [ $USER_ID -ne 0 ]
then
	echo "Current user is not the root user."
else
	echo "Root user detected."
fi



#check if package is already installed or not

dnf list installed git

	#check if above command exec successfully
if [ $? -eq 0 ]
then
	echo "Package already installed"
else
	echo "Package not found in installed list"

#if not installed, install the package
	dnf install git

fi

#check if package is installed correctly
dnf list installed git

if [ $? -eq 0 ]
then
	echo "Package installed successfully"
else
	echo "Package installation failed"
fi
