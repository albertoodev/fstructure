source error.sh
# feature
function __feature() {
    cd $r/lib && __init_files $1 || __error
}

function __init_files() {
    __create_structure $1 # && __put_content
}

function __create_structure() {
    mkdir features/$1
    cd features/$1 &&
        mkdir domain data presentation &&
        mkdir data/{data_sources,models,repositories} domain/{entities,repositories,use_cases} presentation/{screens,widgets,providers} ||
        __error
}
