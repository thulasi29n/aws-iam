#!/bin/bash
# Purpose: Automated user creation in the AWS
# How to: ./aws-create-users.sh <entry file format .csv>
# Entry file column name: user, group, password
# Author: Thulasiram V
# ------------------------------------------
sudo yum install dos2unix -y
INPUT=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

command -v dos2unix >/dev/null || { echo "dos2unix tool not found. Please, install dos2unix tools before running the script."; exit 1; }

dos2unix $INPUT

while read -r user group password || [ -n "$user" ]
do
    if [ "$user" != "user" ]; then
	echo "Creating User" - $user
	    aws iam create-user --user-name $user
		echo  "Attaching password reset condition...!"
        aws iam create-login-profile --password-reset-required --user-name $user --password $password
		echo  "Attaching User-" $user "-to Group-" $group
        aws iam add-user-to-group --group-name $group --user-name $user
		echo "User-" $user " Created and Attached to Group-" $group
	fi
    

done < $INPUT

IFS=$OLDIFS