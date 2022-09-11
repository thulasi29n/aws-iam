#!/bin/bash
# Purpose: Automated user group and policy creation in the AWS
# How to: ./aws-iam-creategroup-attachpolicy.sh <entry file format .csv>
# Entry file column name: groupname, cstmpolicy, pwdpolicy
# Author: Thulasiram V
# ------------------------------------------
sudo yum install dos2unix -y

INPUT=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

command -v dos2unix >/dev/null || { echo "dos2unix tool not found. Please, install dos2unix tools before running the script."; exit 1; }

dos2unix $INPUT

pwdpolicy=arn:aws:iam::aws:policy/IAMUserChangePassword
while read -r groupname cstmpolicy || [ -n "$groupname" ]
do
	if [ "$groupname" != "groupname" ]; then
	echo "Creating User-Group" - $groupname
	  aws iam create-group --group-name $groupname
	  echo  echo "Attaching policies...!"
      aws iam attach-group-policy --group-name $groupname --policy-arn $cstmpolicy
	  aws iam attach-group-policy --group-name $groupname --policy-arn $pwdpolicy
	  echo "UserGroup-" $groupname  "-Created & Policies-" $cstmpolicy "&" $pwdpolicy "- attached".
	fi
done < $INPUT

IFS=$OLDIFS