#!/bin/bash

echo "All the variables passed to the script is $@"
echo "Number of varibales passed to the script is $#"
echo "Script name is $0"
echo "current working directory is $PWD"
echo "Home directory of current user is $HOME"
echo "PID of the executing script is $$"
sleep 100 &
echo "PID of the last executed background process $!"
