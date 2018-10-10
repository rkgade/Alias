#! /bin/bash

if [ -d $1 ] || [ -z $1 ] 
then 
	echo error:Invalid input
	exit

elif [ ! -e $1 ]
then
	echo error: Backup cannot be created. "$1" file does not exist.

else
        
	
	cp  $1  "$1".bkp  
	var0="$1".bkp
	
	vim $1


	var1="$(sha512sum $1)" 
        var2="$(sha512sum  "$var0")"       

	if [ "$var2" == "$var1" ]
	then
		echo No changes in the file
		exit

	else
		diff $var0 $1

		echo 
		echo
		echo Do you want to keep edited version of the file?

		read input

		if [ "$input" = yes ]
		then
			cp $1 "$1".bkp
			
		else
			cp "$1".bkp $1
			echo Changes to file discarded.

		fi
	fi
fi


                    
