#! /bin/bash

#get search term
read -p "enter a search term: " search

#make directory to store all found files
mkdir ./found_files

#searching folders in nested directory
for i in $(find . -type d);
do
	#don't search created folder
	if [ $i != "./found_files"]; then
		echo "**********Folder $i *************"
		
		for myfile in $i/*;
		do
			#check item is file not folder
			if [ -f "$myfile" ]; then
				#search for search term in file contents
				check=$(grep -ni "$search" "$myfile")
				if [ -z $check ]; then
					echo "empty"
				else
					#get filename without path
					name_f=$(basename $myfile)
					#copy matched file to found_folder
					cp "$myfile" ./found-folder/"$name_f"
					
					#append line where the term was found with line number
					echo "***********" >> found_folder/"$name_f"
					echo "$check" >> found-folder/"$name_f"
				fi
			fi
		done
	fi
done
