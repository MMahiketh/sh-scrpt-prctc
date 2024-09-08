#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

#Function for checking installed packages

CHECK_PKG (){

	dnf list installed $1
		#check if above command exec successfully
	if [ $? -eq 0 ]
	then
		echo "$B $1 $N already installed... $Y SKIPPING $N"	#term+log
		exit 0
	else
		echo -e "$B $1 $R not found $N in installed packages"	#log
	fi
}

CHECK_USER(){

	#check if current user is root user
        echo "Checking if user is root"					#log

        USER_ID=$(id -u)
	#echo "$USER_ID"

        if [ $USER_ID -ne 0 ]
        then
                echo -e "$R Not root user $N .Please execute the $0 as root" 		#term+log
                exit 1
        else
                echo -e "$G Root user $N detected."			#log
        fi

}


INSTALL_PKG(){

	echo "Installing $1"						#log
	dnf install $1 -y
		#Check for successfull installation
	if [ $? -ne 0 ]
	then
		echo -e "$1 $R installation FAILED... $N Please check."	#term+log
	else
		echo -e "$1 $G installation SUCCESS... $N"		#term+log
	fi
}

USAGE(){

	if [ $# -eq 0 ]
	then
		echo -e "$R USAGE:: $N Pass the packages as arguments"
		echo "$0 package1 package2 package3 ..."
		exit 1
	fi
}


PACKAGES=$@

#Usage instructions
USAGE $PACKAGES

	#Checking for root user
CHECK_USER

for PACKAGE in $PACKAGES
do
	#check if package is already installed or not
	CHECK_PKG $PACKAGE

	#if not installed, install the package
	echo "Trying to install... $PACKAGE"

	INSTALL_PKG $PACKAGE
done
