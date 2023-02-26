#!/bin/bash
#--------------------------#
## main ##
r=$(pwd)
FILES_PATH=$(find ~ -name flutter_project_structure)/files

# _menus ................................................
function __select_num_menu() {
	printf "1) init\n2) new feature\n3) create model\nq) exit\n"
	echo "Enter your choice : "
}

function __select_feature_menu() {
	echo "Select a feature (Write the name) : "
	echo $(ls $r/lib/features)
}

# _init ................................................
function __init() {
	cd $r/lib && __init_files || __error
}

function __init_files() {
	__create_structure && __put_content || __error
}

function __create_structure() {
	mkdir core features debug_log &&
		mkdir core/{app,dependency_injection,errors,navigation,strings,theme} &&
		touch core/{config,app/app,errors/{exceptions,failures},dependency_injection/injection,navigation/navigation,strings/strings,theme/{colors,theme}}.dart
}
function __put__() {
	cat $1/$2.dart >core/$2.dart
}
function __put_content() {
	__put__ $FILES_PATH app/app
	__put__ $FILES_PATH errors/failures
	__put__ $FILES_PATH navigation/navigation
	__put__ $FILES_PATH theme/theme
	__put__ $FILES_PATH theme/colors
}

# _feature ................................................

function __feature() {
	echo 'name of the feature : '
	read -r feature
	if [ '$feature' -e '' ]; then
		echo "name of the feature most not be Empty"
	else
		cd $r/lib && __init_feature_files $feature || __error
	fi
}

function __init_feature_files() {
	__create_feature_structure $1 # && __put_content
}

function __create_feature_structure() {
	mkdir features/$1 &&
		cd features/$1 &&
		mkdir domain data presentation &&
		mkdir data/{data_sources,models,repositories} domain/{entities,repositories,use_cases} presentation/{screens,widgets,providers} ||
		__error
}
# _create_model ................................................
function __create_model() {
	__select_feature_menu
	read -r feature
	echo "Model name"
	read -r model
	cd $r/lib/features/$feature
	touch {domain/entities/,data/models/}$model.dart
}

# functions ................................................
function __press_any_key() {
	read -n1 -r -p "Press any key to continue..."
	clear
}

function __error() {
	printf "something went wrong ... \n"
	return 1
}

# project structure --------------------------#
function project_structure() {
	while true; do
		__select_num_menu
		read -r num
		clear
		case $num in
		1)
			echo "Init..."
			__init
			;;
		2)
			echo "New feature..."
			__feature
			;;
		3)
			echo "Create model..."
			__create_model
			;;
		q)
			return 0
			;;
		*)
			echo "Invalid input"
			;;
		esac
		cd "$r" || __error
		__press_any_key
	done
}
project_structure