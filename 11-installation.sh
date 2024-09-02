#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please run script with root user"
    exit 1
fi

dnf list installed ansible

if [ $? -ne 0]; then
    echo "Ansible is not installed, going to install ansible"
    dnf install ansible -y
else
    echo "Ansible is already installed"
fi
