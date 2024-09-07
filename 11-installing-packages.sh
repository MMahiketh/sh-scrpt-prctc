#!/bin/bash

PACKAGE=$1

	#check if package is already installed or not
dnf list installed $PACKAGE

		#check if above command exec successfully
if [ $? -eq 0 ]
then
	echo "$PACKAGE already installed"
	exit 0
else
	#if not installed, install the package
	echo "$PACKAGE not found in installed list"
	echo "Trying to install $PACKAGE"

	#check if current user is root user
	echo "Verifying if user is root user"
	
	USER_ID=$(id -u)
#	echo "$USER_ID"

	if [ $USER_ID -ne 0 ]
	then
		echo "Current user is not the root user"
		echo "Execute the script with root user"
		exit 1
	else
		echo "Root user detected."
		echo "Installing $PACKAGE"
		dnf install $PACKAGE -y
	fi
fi

	#check if package is installed correctly

dnf list installed $PACKAGE

if [ $? -ne 0 ]
then
	echo "$PACKAGE installation failed"
else
	echo "$PACKAGE installed successfully"
fi
