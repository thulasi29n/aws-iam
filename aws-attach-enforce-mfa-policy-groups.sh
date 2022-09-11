#!/bin/bash
# Purpose: Automated user group and policy creation in the AWS
# How to: ./aws-attach-enforec-mfa-policy-groups.sh <entry file format .csv>
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

enforcemfapolicy=arn:aws:iam::xxxxxxxxxx:policy/EnforceMFAPolicy
while read -r groupname || [ -n "$groupname" ]
do
	if [ "$groupname" != "groupname" ]; then
	echo "Attaching MFA Policy -Group" - $groupname
	  aws iam attach-group-policy --group-name $groupname --policy-arn $enforcemfapolicy
	  echo "UserGroup-" $groupname  "-Attached with  MFA Policies-" $enforcemfapolicy.
	fi
done < $INPUT

IFS=$OLDIFS