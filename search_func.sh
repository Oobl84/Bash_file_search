#! /bin/bash

get_file() {
	
	local str="$1"
	local fil="$2"
	
	# echo "the term you are searching for is $str. "
	# echo "the file you are searching in is $file. "
	
	# grep -ni $str $fil
	
	check=$(grep -ni "$str" "$fil")
	
	if  [ -z "$check" ]; then
		echo "### term not found ###"
	else
		echo "found!"
		local name_file = $(basename "$fil")
		
		cp "$fil" found_files/"$name_file"
		echo " " >> found_files/"$name_file"
		echo "*----------------------------*" >> found_files/"$name_file"
		echo "$check" >> found_files/"$name_file"
	fi
}

########## Program #############################

rm -r /found_files
mkdir ./found_files

#get search term
read -p "enter a search term: " search

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
				get_file "$search" "$myfile"	
			fi
		done
	fi
	echo "------------------"
done

########### End of Program ####################