#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

#/var/log/<shell_script>/<script-name>-<timestamp>.log

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0|cut -d "." -f1)
#echo "$SCRIPT_NAME"
TIME_STAMP=$(date +%Y-%m-%d::%H:%M:%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"
#echo "$LOG_FILE"


#Function for checking root user

CHECK_USER(){

	#check if current user is root user
        echo "Checking if user is root" &>> $LOG_FILE

        USER_ID=$(id -u)
	#echo "$USER_ID"

        if [ $USER_ID -ne 0 ]
        then
                echo -e "$R Not root user $N .Please execute the $0 as root" | tee -a $LOG_FILE
                exit 1
        else
                echo -e "$G Root user $N detected." &>> $LOG_FILE
        fi

}


#Function for installing package

INSTALL_PKG(){

	echo "Installing $1" &>> $LOG_FILE
	dnf install $1 -y &>> $LOG_FILE
		#Check for successfull installation
	if [ $? -ne 0 ]
	then
		echo -e "$1 $R installation FAILED... $N Please check." | tee -a $LOG_FILE
	else
		echo -e "$1 $G installation SUCCESS... $N" | tee -a $LOG_FILE
	fi
}

#Function for checking installed packages & installing them

CHECK_PKG (){

	dnf list installed $1 &>> $LOG_FILE
		#check if above command exec successfully
	if [ $? -eq 0 ]
	then
		echo -e "$B $1 $N already installed... $Y SKIPPING $N" | tee -a $LOG_FILE
	else
		echo -e "$B $1 $R not found $N in installed packages" &>> $LOG_FILE
		echo "Trying to install... $PACKAGE" &>> $LOG_FILE
			#if not installed, install the package
		INSTALL_PKG $1
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

sudo mkdir -p $LOGS_FOLDER

#Checking for root user
CHECK_USER


#Usage instructions
USAGE $PACKAGES

for PACKAGE in $PACKAGES
do
	#check if package is already installed. If not install it.
	CHECK_PKG $PACKAGE
done
