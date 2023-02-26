#!/bin/bash
#--------------------------#
## main ##
r=$(pwd)
FILES_PATH=$(find ~ -name flutter_project_structure)/files

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
	if [ '$1' -e '' ]; then
		echo "name of the feature most not be Empty"
	else
		cd $r/lib && __init_feature_files $1 || __error
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
	cd $r/lib/features/$1
	touch {domain/entities/,data/models/}$2.dart
}

# functions ................................................
function __error() {
	printf "something went wrong ... \n"
	return 1
}

# project structure --------------------------#
function project_structure() {
	case $1 in
	'-i')
		echo "Init..."
		__init &&
		echo 'done'
		;;
	'-f')
		echo "New feature..."
		__feature $2 &&
		echo 'done'
		;;
	'-m')
		echo "Create model..."
		__create_model $2 $3 &&
		echo 'done'
		;;
	*)
		echo "Invalid input"
		;;
	esac
	cd "$r" || __error
}