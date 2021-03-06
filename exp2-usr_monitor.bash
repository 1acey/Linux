#!/bin/bash
#Program:
#       Experiment 2: User Login Monitor
#History:
#2017/11/29 1ance First release

if [ $# != 1 ]
then
        echo "Usage: user_monitor username"
        exit
fi

#Get user list
userlist=`who | cut -d " " -f 1`
echo -e "Current user list is:\n"$userlist

#Determine whether the username inputted in the user list
while [ true ]
do
        userlist=`who | cut -d " " -f 1`
        if echo "$userlist" | grep -wq "$1$"
        then
                echo  -e "\nuser[$1] is logon"
                exit
        else
                echo -e "\nwaiting user[$1] login...\c" #waiting for specified user to login
                sleep 5
        fi
done
