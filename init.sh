source error.sh
## init 
function __init(){
	cd $(pwd)/lib  && __init_files || __error
}

function __init_files() {
   __create_structure && __put_content
}

function __create_structure(){
	mkdir core features debug_log
	mkdir core/{app,dependency_injection,errors,navigation,strings,theme} 
	touch core/{config,app/app,errors/{exceptions,failures},dependency_injection/injection,navigation/navigation,strings/strings,theme/{colors,theme}}.dart 
}

function __put_content(){
	FILES_PATH=$(find ~ -name alberto_flutter_project_structure)/files
	echo $FILES_PATH
	paths=(app/app errors/failures navigation/navigation theme/theme theme/colors)
	for path in $paths
	do
    	cat $FILES_PATH/$path.dart > core/$path.dart
	done
}