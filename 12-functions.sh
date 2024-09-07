#!/bin/bash

#Function for checking installed packages

CHECK_PKG (){

	dnf list installed $1
		#check if above command exec successfully
	if [ $? -eq 0 ]
	then
		echo "$1 listed in installed packages"
		exit 0
	fi	
}

CHECK_USER(){

	#check if current user is root user
        echo "Checking if user is root"

        USER_ID=$(id -u)
	#echo "$USER_ID"

        if [ $USER_ID -ne 0 ]
        then
                echo "Current user is not the root user"
                echo "Please execute the $0 as root user"
                exit 1
        else
                echo "Root user detected."
        fi

}

PACKAGE=$1

	#check if package is already installed or not
CHECK_PKG $PACKAGE

	#if not installed, install the package
echo "$PACKAGE not found in installed list"
echo "Trying to install $PACKAGE"

	#Checking for root user
CHECK_USER

echo "Installing $PACKAGE"
dnf install $PACKAGE -y

CHECK_PKG $PACKAGE

echo "$PACKAGE installation failed"
