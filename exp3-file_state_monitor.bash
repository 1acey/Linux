#!/bin/bash
#Program:
#	Experiment3:File State Query
#Function:
#	Dynamically monitor specified file's state. when the size of file has changed, output message and go on monitoring. When the times of changes or times of non-changes has reached a threshold, output message and exit
#History:
#2017/11/29	1ance	First release

if [ $# != 0 ]
then
	echo "Usage: file_state_monitor"
	exit
fi

filename=""
clear
read -p "Input the file name your want to monitor:" filename

#Determine whether the specified file exists
if ls -l | grep -wq "$filename$" 
then
	echo "Current status of [$filename] is:"
	ls -l | grep -w "$filename$"
else
	echo "No such file!"
	exit
fi

#Cut the "size of file" field from `ls -l | grep -wq "$filename$"`
filesize=`ls -l | grep -w "$filename$" | awk '{print $5}'`
echo "The size of [$filename] is $filesize"

#Test whether the file size changed
file_change_times=0
file_nochange_times=0
while [ true ]
do
	echo -e "\nTesting ${filename}'s status..."
	sleep 5s
	filesize_new=`ls -l | grep -w "$filename$" | awk '{print $5}'`
	if [ $filesize_new != $filesize ]
	then
		filesize=filesize_new
		echo "file [$filename] size changed"
		file_change_times=`expr $file_change_times + 1`
		if [ $file_change_times -eq 2 ]
		then
			echo "The size of $filename has changed $file_change_times times"
			clear;exit
		fi
	else
		file_nochange_times=`expr $file_nochange_times + 1`
		if [ $file_nochange_times -eq 10 ]
		then	
			echo "Test exceed $file_nochange_times times and the size of $filename didn't change"
			clear;exit
		fi
	fi		
done
