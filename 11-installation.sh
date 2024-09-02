#!/bin/bash

USERID=$(id -u)

if [ $USERID -eq 0 ]; then
    dnf install ansible
else
    echo "please execute script with root user"
fi

dnf list installed ansible
