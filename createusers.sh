#!/bin/bash
#######################################################
#Create Users from file and add them to appropriate groups
#
#HR sends a csv file with users and grops they should be in.
#
#This script creates those users set their password to be same as their name and 
#adds them to wished groups.
#
#
#
#template of csv file:
#names.csv
#
#testuser1,g1,g2
#testuser2,g1
#testuser3,g2
#
#
########################################################
file="${1:? <file_with_users.csv>}"
function creategroup(){
	IFS=',' read -ra linearr <<< "${@}"
	for i in "${linearr[@]:1}"; do
		if [ ! $(getent group "${i}") ]; then
       			 groupadd "${i}"
       			 else
               		 echo "group "${i}" exists"
		fi
	done
}

function createuser(){
	IFS=',' read -ra linearr <<< "${@}"
	useradd -p $(openssl passwd "${linearr[0]}")  "${linearr[0]}"
	passwd -e "${linearr[0]}"
	
	
	#add users to appropriate group
	for i in "${linearr[@]:1}"; do
		gpasswd -a "${linearr[0]}" "${i}"
	done
}

function main(){
	mapfile -t arr < "${file}"
	for i in "${arr[@]}"; do
		creategroup "${i}";
	done
	for i in "${arr[@]}"; do
		createuser "${i}"; 
	done	
}
main "${@}"
