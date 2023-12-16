#!/bin/bash

# Getting the name of the user, which executed the script
user=$(whoami)
echo "Information on the user $user:"

#Printing the user's record from /etc/passwd
echo -e "\nThe user's record from /etc/passwd:"
grep "^$user:" /etc/passwd

echo -e "\nInformation on the time of login:"
last -n 1 $user

echo -e "\nGroups in which the user is in:"
groups $user

echo -e "\nContents of the home directory:"
ls -la /home/$user