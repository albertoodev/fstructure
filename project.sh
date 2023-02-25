#!/bin/bash
## imports ##
source init.sh
source error.sh
source menu.sh
#--------------------------#
## main ##
r=$(pwd)
#--------------------------#
function structer() {
	while true; do
		__menu1
		read -r num
		case $num in
		1)
			echo "Init..."
			__init
			cd $r || __error
			;;
		2)
			echo "New feature..."
			;;
		q)
			clear
			return 0
			;;
		*)
			echo "Invalid input"
			;;
		esac
		__press_any_key
	done
}

function __press_any_key() {
	echo "Press any key to continue..."
	read -n 1 -s key
	clear
}
