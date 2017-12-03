#!/bin/sh
#Programe:
#	Experiments1:file establish and keyboard input
#Function:
#	get user's input and redirect it to another file
#History:
#2017/11/29 1ance First release

if [ $# != 1 ]
then
	echo "Usage: examl filename"
	exit
fi

INPUT="test"

while [ true ]
do
	if [ -n "$INPUT" ]
	then
		read -p "Now input a string:" INPUT
		echo "$INPUT" >> $1
		echo "Contents of $1 is: "
		cat $1
	else
		break
	fi
done
