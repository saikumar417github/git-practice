#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please run script with root user"
    exit 1
fi

dnf list installed ansible

if [ $? -ne 0 ]; then
    echo "Ansible is not installed, going to install ansible"
    dnf install ansible -y
    if [ $? -ne 0 ]; then
        echo "Ansible installation not successful, check it"
        exit 1
    else
        echo "Ansible installation is successfull"
    fi
else
    echo "Ansible is already installed"
fi

dnf list installed nginx

if [ $? -ne 0 ]; then
    echo "nginx is not installed, going to install it.."
    dnf install nginx -y
    if [ $? -ne 0 ]; then
        echo "nginx installation is incomplete, please check it"
        exit 1
    else
        echo "nginx installation is completed successfully"
    fi
else
    echo "nginx is already installed"
fi
