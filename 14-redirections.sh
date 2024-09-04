#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT() {
    if [ $USERID -ne 0 ]; then
        echo -e "$R please run the script with root user $N" &>>$LOG_FILE
        exit 1
    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 is ... $R FAILED $N" &>>LOG_FILE
        exit 1
    else
        echo -e "$2 is ... $G SUCCESS $N" &>>LOG_FILE
    fi
}

USAGE() {
    echo -e "$R USAGE: $N sudo $0 package1 package2.."
    exit 1
}
CHECK_ROOT

if [ $@ -eq 0 ]; then
    USAGE
fi

for PACKAGE in $@; do
    dnf list installed $PACKAGE &>>LOG_FILE
    if [ $? -ne 0 ]; then
        echo "$PACKAGE is not yet installed, goint ot install it.."
        dnf install $PACKAGE-y &>>LOG_FILE
        validate $? "Installing $PACKAGE"
    else
        echo "$PACKAGE is already $Y installed.. nothing to do $N" &>>LOG_FILE
    fi
done
