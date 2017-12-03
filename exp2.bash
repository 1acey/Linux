#!/bin/sh
#Program:
#       Experiment2: User Login Monitor
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
        if echo "$1" | grep -q "$userlist"
        then
                echo  -e "\nuser[$1] is logon"
                exit
        else
                echo -e "\nwaiting user[$1] login...\c" #waiting for specified user to login
                sleep 5s
        fi
done
