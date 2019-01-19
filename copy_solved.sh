#!/bin/bash

# Copy the solved folders into the corresponding student GitLab directories
# Prefix single digit folders with 0
usage="USAGE: './copy_solved.sh 14 04' -> Will copy all solved folders from activities 1-4 from week 14"

# Base source directory (abs path)
baseSrc=~/Documents/programming/FullStack-Lesson-Plans/01-Class-Content

# Base destination directory FSF08... etc...
baseDest=~/Documents/programming/UNCHILL201808FSF3/class_content

# The number of the activity you want to copy up to
limiter=$2
prefix='0'
if [ ${limiter:0:1} == 0 ]
then 	
	limiter=${limiter:1:1}
fi

if [ $# -eq 0 ]
then
	printf "Please specify a folder to copy from and an activity folder to copy up to.\n$usage\n\n"
elif [ -z $2 ]
then 
	printf "Please specify a an activity directory to copy up to.\n$usage\n\n"
else 
	srcDir="$(find $baseSrc -maxdepth 1 -type d -name "$1-*" -print -quit)"
	week="${srcDir##*/}"
	srcDir=$srcDir/01-Activities
	limitDir="$(find $srcDir -maxdepth 1 -type d -name "$2-*" -print -quit)"
	destDir=$baseDest/$week
	
	n=1
	while [ $n -lt $((limiter+1)) ]
	do 
		if [ ${#n} -gt 1 ]
		then 
			prefix=''
		fi	

		dir="$(find "$srcDir"/ -maxdepth 1 -type d -name "$prefix$n*" -print -quit)"
		# If the directory has a Solved folder
	  	if [ -d "$dir/Solved" ]
		then
			act="${dir##*/}"
			echo "Copying $act"
			cp -ar $dir/Solved $destDir/$act

		fi
		n=$((n+1))
	done
fi

