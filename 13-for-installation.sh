#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT() {
    if [ $USERID -ne 0 ]; then
        echo "Please run this script with root access"
        exit 1
    fi
}
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 is ... $R FAILED $N"
        exit 1
    else
        echo -e "$2 is .. $G SUCCESS $N"
    fi
}

CHECK_ROOT

for package in $@; do
    dnf list installed $package
    if [ $? -ne 0 ]; then
        echo "$PACKAGE is not installed, We are going to install it"
        dnf install $PACKAGE -y
        VALIDATE $? "Installing $PACKAGE"
    else
        echo "$PACKAGE is already installed"
    fi
done
