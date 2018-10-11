#! /bin/bash

default_backup_directory="/tmp"
original=$1

if [ -d $original ] || [ -z $original ] 
then 
	echo error:Invalid input
	exit

elif [ ! -e $original ]
then
	echo warning : Backup cannot be created. "$original" file does not exist.
	echo "Opening New File : $original "

else
        
        backup=$default_backup_directory/"$original".bkp

	cp  $original  $backup
	
	vim $original


	original_gshasum="$(gsha512sum $original)" 
        backup_gshasum="$(gsha512sum  $backup)"       

	if [ "$original_gshasum" == "$backup_gshasum" ]
	then
		echo No changes in the file
		exit

	else
		diff $original $backup

		echo 
		echo
		echo Do you want to keep edited version of the file?

		read input

		if [ "$input" = yes ]
		then
			echo "Removing backup and persisting current version of $original"
			rm $backup

			
		else
			cp "$original".bkp $original
			echo Changes to file discarded.

		fi
	fi
fi


                    
