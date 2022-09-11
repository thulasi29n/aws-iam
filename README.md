# aws-iam
This project for automated user migration and management of AWS Identity and Access Management
![Groups_users](https://user-images.githubusercontent.com/26733874/189531073-a42c5423-45bc-4d35-87f4-ffb17e90d47a.png)

![AWS_IAM_Architecture](https://user-images.githubusercontent.com/26733874/189524879-0b1cc000-22cd-4b6e-b2f6-acbaf53a27e6.png)

1. Open the AWS Cloud Shell

2. Upload the aws-iam-creategroup-attachpolicy.sh script onto AWS CLI (script file is attached)

3. Prepare an CSV file with column names(groupname,cstmpolicy) and provide details.
       --> 2 policies attached for each group (password-reset on first login & appropriate policy)
       --> Ex: CloudAdmin --> arn:aws:iam::aws:policy/IAMUserChangePassword & arn:aws:iam::aws:policy/AWSAccountManagementFullAccess
       --> I have created 4 groups --> VPC,RDS,EC2
4. Upload Groups csv file onto AWS CLI( my version csv file attached).     
5. update execute permission to aws-iam-creategroup-attachpolicy.sh script -        chmod 775 aws-iam-creategroup-attachpolicy.sh
6. Run the script -      ./aws-iam-creategroup-attachpolicy.sh created.csv(CreateGroupsPolicies.csv)
7. Check for the newly created Usergroups and their associated policies.

8. Upload the aws-create-users.sh script onto AWS CLI (script file is attached)
9. Create a csv file with user,group,password and prvoide details for user and password, gname must match with groupname created in step6.(my csv uploaded excluding password)
10.Upload users csv file onto AWS CLI( my version csv file attached). 

11. update execute permission to aws-create-users.sh script -        chmod 775 aws-create-users.sh
12. Run the script -      ./aws-create-users.sh created.csv(users.csv)
13. Check for the newly created users and their associated groups.

##########################################################################################

1. login with one of the user and password provided by you in the csv file.
2. change password on the first login.

############################################################################################

1. login into admin account
2. Create a customer managed policy and name it as "EnforceMFAPolicy" and provide details in json format. (json attached).
3. Assign newly created EnforceMFAPolicy policy to all the usergroups.(you can choose either script for updating this or AWS console or AWS Portal)(Script attached).
4. Create an MFA key to any one of the newly created user using AWS approved authenticator.
5. login into the user account and make sure you are asking for MFA key.

![AWS_IAM](https://user-images.githubusercontent.com/26733874/189524948-51de4526-a140-49af-a1ec-db060898c0de.png)
