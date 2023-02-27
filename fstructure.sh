#!/bin/bash
#--------------------------#
## main ##
r=$(pwd)
FILES_PATH=$(find ~ -name fstructure)/files

# _init ................................................
function __init() {
	cd $r/lib && __init_files || __error
}

function __init_files() {
	__create_structure && __put_content || __error
}

function __create_structure() {
	mkdir core features debug_log &&
		mkdir core/{app,errors,navigation,strings,theme} &&
		touch core/{config,app/app,errors/{exceptions,failures},navigation/navigation,strings/strings,theme/{colors,theme}}.dart
	touch debug_log/log.dart
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
	cd $r/lib/features && __create_feature_structure $1 || __error
}

function __create_feature_structure() {
	mkdir $1 &&
		cd $1 &&
		mkdir domain data presentation &&
		mkdir data/{data_sources,models,repositories} domain/{entities,repositories} presentation/{screens,providers} ||
		__error
}
# _create_model ................................................
function __create_model() {
	cd $r/lib/features/$1
	touch domain/entities/$2.dart data/models/$2_model.dart
}
# _create_repository ..........................................
function __create_repository() {
	cd $r/lib/features/$1
	touch domain/repositories/$2_repository.dart data/repositories/$2_data_repository.dart
}

# _create_data_source ..........................................
function __create_data_source() {
	cd $r/lib/features/$1
	touch data/data_sources/$2_data_source.dart
}

# _create_provider ..........................................
function __create_provider() {
	cd $r/lib/features/$1
	touch presentation/providers/$2_provider.dart
}
# _create_screen ..........................................
function __create_screen() {
	cd $r/lib/features/$1/presentation/screens/
	mkdir $2 && mkdir $2/widgets
	touch $2/$2.dart
}

# _create_feature_screen ..........................................
function __create_feature_screen() {
	cd $r/lib/features/
	mkdir $1 && mkdir $1/{widgets,providers}
	touch $1/$1.dart
}
# functions ................................................
function __error() {
	printf "something went wrong ... \n"
	return 1
}

# project structure --------------------------#
function fs() {
	case $1 in
	'-i')
		if [ "$#" -ne '1' ]; then
			__error &&
				return 1
		else
			echo "Init..."
			__init &&
				echo 'done'
		fi
		;;
	'-f')
		if [ "$#" -ne '2' ]; then
			__error &&
				return 1
		else
			echo "New feature..."
			__feature $2 &&
				echo 'done'
		fi
		;;
	'-sf') # show features
		if [ "$#" -ne '1' ]; then
			__error &&
				return 1
		else
			echo "$(ls $r/lib/features)"
		fi
		;;
	'-m')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create model..."
			__create_model $2 $3 &&
				echo 'done'
		fi
		;;
	'-r')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create repository..."
			__create_repository $2 $3 &&
				echo 'done'
		fi
		;;
	'-d')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create Data Source ..."
			__create_data_source $2 $3 &&
				echo 'done'
		fi
		;;
	'-p')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create Provider ..."
			__create_provider $2 $3 &&
				echo 'done'
		fi
		;;
	'-s')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create Screen ..."
			__create_screen $2 $3 &&
				echo 'done'
		fi
		;;
	'-fs')
		if [ "$#" -ne '2' ]; then
			case $3 in
			'w')
			#create widget
			;;
			'p')
			#create provider
			;;
			*)
				__error &&
				return 1
			;; 
			esac
		else
			echo "Create Feature Screen ..."
			__create_feature_screen $2 &&
				echo 'done'
		fi
	;;
	*)
		echo "Invalid input"
		;;
	esac
	cd "$r" || __error
}
