#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"

#Function for checking installed packages

CHECK_PKG (){

	dnf list installed $1
		#check if above command exec successfully
	if [ $? -eq 0 ]
	then
		echo "$1 listed in installed packages"
		exit 0
	else
		echo "$1 $R not found $N in installed packages"
	fi	
}

CHECK_USER(){

	#check if current user is root user
        echo "Checking if user is root"

        USER_ID=$(id -u)
	#echo "$USER_ID"

        if [ $USER_ID -ne 0 ]
        then
                echo "Current user is $R not root user $N"
                echo "Please execute the $0 as root user"
                exit 1
        else
                echo "$G Root user $N detected."
        fi

}


INSTALL_PKG(){

	echo "Installing $1"
	dnf install $1 -y
		#Check for successfull installation
	if [ $? -ne 0 ]
	then
		echo "$1 $R installation failed... $N Please check."
	else
		echo "$1 $G installed successfully... $N"
	fi
}

PACKAGE=$1

	#check if package is already installed or not
CHECK_PKG $PACKAGE

	#if not installed, install the package
echo "Trying to install $PACKAGE"

	#Checking for root user
CHECK_USER

INSTALL_PKG $PACKAGE
