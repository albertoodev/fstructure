#!/bin/bash
#--------------------------#
## main ##
r=$(pwd)
FILES_PATH=$(find ~ -name fstructure)/files

# functions ................................................
function __error() {
	printf "something went wrong ... \n"
	return 1
}

function __to_class_name() {
	echo "$1" | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/^./\U&/'
}
## file feature name
function __change_content() {
	text=$(cat $FILES_PATH/$1)
	text="${text//featuree/$2}"
	text="${text//Example/$(__to_class_name $3)}"
	text="${text//example/$3}"
	echo "$text"
}

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
		mkdir src/general/{widgets,screens,providers} &&
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
	touch domain/entities/$2.dart data/models/$2_model.dart &&
		echo "$(__change_content model/entity.dart $1 $2)" >domain/entities/$2.dart &&
		echo "$(__change_content model/model.dart $1 $2)" >data/models/$2_model.dart ||
		__error
}
# _create_repository ..........................................
function __create_repository() {
	cd $r/lib/src/features/$1
	touch domain/repositories/$2_repository.dart data/repositories/$2_data_repository.dart &&
		echo "$(__change_content repositories/repository.dart $1 $2)" >domain/repositories/$2_repository.dart &&
		echo "$(__change_content repositories/data_repository.dart $1 $2)" >data/repositories/$2_data_repository.dart ||
		__error
}

# _create_data_source ..........................................
function __create_data_source() {
	cd $r/lib/src/features/$1
	touch data/data_sources/$2_data_source.dart &&
		echo "$(__change_content data_source/data_source.dart $1 $2)" >data/data_sources/$2_data_source.dart ||
		__error
}

# _create_provider ..........................................
function __create_provider() {
	cd $r/lib/src/features/$1
	touch presentation/providers/$2_provider.dart &&
		echo "$(__change_content presentation/provider.dart $1 $2)" >presentation/providers/$2_provider.dart ||
		__error
}
# _create_widget ..........................................
function __create_widget() {
	cd $r/lib/src/features/$1
	touch presentation/screens/$2/widgets/$3_widget.dart &&
		echo "$(__change_content presentation/widget.dart _ $3)" >presentation/screens/$2/widgets/$3_widget.dart ||
		__error
}

# _create_general_widget ..........................................
function __create_general_widget() {
	cd $r/lib/src/general
	touch widgets/$1_widget.dart &&
		echo "$(__change_content presentation/widget.dart _ $1)" >widgets/$1_widget.dart ||
		__error
}
# _create_screen ..........................................
function __create_screen() {
	cd $r/lib/src/features/$1/presentation/screens/
	mkdir $2 && mkdir $2/widgets
	touch $2/$2.dart &&
		echo "$(__change_content presentation/screen.dart $1 $2)" >$2/$2.dart ||
		__error
}

# _create_normal_screen ..........................................
function __create_normal_screen() {
	cd $r/lib/src/general/screens
	mkdir $1 && mkdir $1/widgets
	touch $1/$1.dart &&
		echo "$(__change_content presentation/screen.dart _ $1)" >$1/$1.dart ||
		__error
}

# _create_new_failure .........................................

function __create_new_failure() {
	if [ "$#" -gt 1 ]; then
		if [ -d "lib/core/errors" ]; then
			i=2
			while [ "$i" -le "$#" ]; do
				value=$(eval "echo \"\${$i}\"")
				__create_error $value
				i=$((i + 1))
			done
		else
			echo "You need init the project first"
		fi
	else
		echo "ERROR: Invalid command or incorrect number of arguments."
	fi
}
# _create_error .................................................

function __create_error() {
	cd "$r/lib/core/errors" &&
		echo "\n$(__change_content errors/new_error.dart _ $1)\n" >>exceptions.dart &&
		echo "\n$(__change_content errors/new_failure.dart _ $1)\n" >>failures.dart ||
		echo "something went wrong ..."
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
	'-cf')
		__create_new_failure $@
		;;
	'--help')
		__help
		;;
	*)
		echo ""
		;;
	esac
	cd "$r" || __error
}

function fsm() {
	op=''
	case $1 in
	'-f')
		if [ "$#" -gt 3 ]; then
			if [ -d "lib/src/features/$2" ]; then
				local i=3
				while [ "$i" -le "$#" ]; do
					opt=$(eval "echo \"\${$i}\"")
					case $opt in
					-*)
						op="$opt"
						;;
					*)
						if [ "$op" != "" ] && [ "$opt" != "" ]; then
							case $op in
							'-ds')
								echo "Create $opt data source in the $2 feature ..."
								__create_data_source $2 $opt &&
									echo 'done'
								;;
							'-r')
								echo "Create $opt repository in the $2 feature ..."
								__create_repository $2 $opt &&
									echo 'done'
								;;
							'-m')
								echo "Create $opt model in the $2 feature ..."
								__create_model $2 $opt &&
									echo 'done'
								;;
							'-p')
								echo "Create $opt provider in the $2 feature ..."
								__create_provider $2 $opt &&
									echo 'done'
								;;
							'-s')
								echo "Create $opt screen in the $2 feature ..."
								__create_screen $2 $opt &&
									echo 'done'
								;;
							esac
						fi
						;;
					esac
					i=$((i + 1))
				done
			else
				echo "$2 feature not exists"
			fi
		else
			echo ""
		fi
		;;
	'-fs')
		if [ "$#" -gt 4 ]; then
			if [ -d "lib/src/features/$2" ]; then
				if [ -d "lib/src/features/$2/presentation/screens/$3" ]; then
					local i=4
					while [ "$i" -le "$#" ]; do
						widget=$(eval "echo \"\${$i}\"")
						__create_widget $2 $3 $widget
						i=$((i + 1))
					done
				else
					echo "$3 screen not exists in the $2 feature \n to create a new screen you can use the 'fs -fs' command"
				fi
			else
				echo "$2 feature not exists \n to create a new feature you can use the 'fs -f' command"
			fi
		else
			echo "ERROR: Invalid command or incorrect number of arguments. Please try again or use the --help command for more information."
		fi
		;;
	'--help')
		__help_fsm
		;;
	*)
		echo "ERROR: Invalid command or incorrect number of arguments. Please try again or use the --help command for more information."
		;;
	esac
}

function __help() {
	echo "Usage: fs [command] [arguments]"
	echo ""
	echo "Commands:"
	echo "  -i              Initialize the project"
	echo "  -f [feature]    Create a new feature"
	echo "  -fd [feature] [data-source] Create a new data source in a feature"
	echo "  -fr [feature] [repository] Create a new repository in a feature"
	echo "  -fm [feature] [model] Create a new model in a feature"
	echo "  -fp [feature] [provider] Create a new provider in a feature"
	echo "  -fs [feature] [screen] Create a new screen in a feature"
	echo "  -fsw [feature] [screen] [widget] Create a new widget in a screen of a feature"
	echo "  -sf             Show available features"
	echo "  -gw [widget]    Create a new general widget"
	echo "  -ns [screen]    Create a new normal screen"
	echo "  -cf [failures]    Create a new failures in the failures and exceptins files"
	echo ""
	echo "Examples:"
	echo "  fs -i                     # Initializes the project"
	echo "  fs -f authentication      # Creates a new feature named 'authentication'"
	echo "  fs -fd authentication api # Creates a new data source named 'api' in the 'authentication' feature"
	echo "  fs -sf                    # Lists all available features"
	echo "  fs -gw button             # Creates a new general widget named 'button'"
}

function __help_fsm() {
	echo "Usage: fsm -f FEATURE COMMANDS [OPTIONS]"
	echo ""
	echo "A script to automate the creation of common files and directories in a Flutter project."
	echo ""
	echo "Commands:"
	echo "  -ds NAMES    create a new data sources with the specified NAMES in the given FEATURE"
	echo "  -r NAMES     create a new repositories with the specified NAMES in the given FEATURE"
	echo "  -m NAMES    create a new models with the specified NAME in the given FEATURE"
	echo "  -p NAMES     create a new providers with the specified NAMES in the given FEATURE"
	echo "  -s NAMES     create a new screens with the specified NAMES in the given FEATURE"
	echo ""
	echo "Options:"
	echo "  -f FEATURE  specify the FEATURE to create the files/directories in"
	echo ""
	echo "Examples:"
	echo "  fsm -f auth -ds users login -m user      create a new data sources called 'users' and 'login' and new model called 'user' in the 'auth' feature"
	echo "  fsm -f home -r products      create a new repository called 'products' in the 'home' feature"
	echo "  fsm -f profile -m user       create a new model called 'user' in the 'profile' feature"
}
