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
	mkdir core src debug_log &&
		mkdir core/{app,errors,navigation,strings,theme} src/{features,general} &&
		mkdir src/general/{widgets,screens} &&
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
	cd $r/lib/src/features && __create_feature_structure $1 || __error
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
	cd $r/lib/src/features/$1
	touch domain/entities/$2.dart data/models/$2_model.dart
}
# _create_repository ..........................................
function __create_repository() {
	cd $r/lib/src/features/$1
	touch domain/repositories/$2_repository.dart data/repositories/$2_data_repository.dart
}

# _create_data_source ..........................................
function __create_data_source() {
	cd $r/lib/src/features/$1
	touch data/data_sources/$2_data_source.dart
}

# _create_provider ..........................................
function __create_provider() {
	cd $r/lib/src/features/$1
	touch presentation/providers/$2_provider.dart
}
# _create_widget ..........................................
function __create_widget() {
	cd $r/lib/src/features/$1
	touch presentation/screens/$2/widgets/$3_widget.dart
}

# _create_general_widget ..........................................
function __create_general_widget() {
	cd $r/lib/src/general
	touch widgets/$1_widget.dart
}
# _create_screen ..........................................
function __create_screen() {
	cd $r/lib/src/features/$1/presentation/screens/
	mkdir $2 && mkdir $2/widgets
	touch $2/$2.dart
}

# _create_normal_screen ..........................................
function __create_normal_screen() {
	cd $r/lib/src/general/screens
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
	'-fd')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create $3 data source in the $2 feature ..."
			__create_data_source $2 $3 &&
				echo 'done'
		fi
		;;
	'-fr')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create $3 repository in the $2 feature ..."
			__create_repository $2 $3 &&
				echo 'done'
		fi
		;;
	'-fm')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create $3 model in the $2 feature ..."
			__create_model $2 $3 &&
				echo 'done'
		fi
		;;
	'-fp')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create $3 provider in the $2 feature ..."
			__create_provider $2 $3 &&
				echo 'done'
		fi
		;;
	'-fs')
		if [ "$#" -ne '3' ]; then
			__error &&
				return 1
		else
			echo "Create $3 screen in the $2 feature ..."
			__create_screen $2 $3 &&
				echo 'done'
		fi
		;;
	'-fsw')
		if [ "$#" -ne '4' ]; then
			__error &&
				return 1
		else
			echo "Create $4 widget in the $3 screen in the $2 feature ..."
			__create_widget $2 $3 $4 &&
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
	'-gw') # show features
		if [ "$#" -ne '2' ]; then
			__error &&
				return 1
		else
			echo "Create $2 general widget..."
			__create_general_widget $2 &&
				echo 'done'
		fi
		;;
	'-ns')
		if [ "$#" -ne '2' ]; then
			__error &&
				return 1
		else
			echo "Create $2 Screen ..."
			__create_normal_screen $2 &&
				echo 'done'
		fi
		;;
	*)
		echo "Invalid input"
		;;
	esac
	cd "$r" || __error
}
