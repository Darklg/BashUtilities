#!/bin/bash

###################################
## FILES V 0.8.0
###################################

## SED FOR LINUX / OSX
###################################

# EXAMPLE :
# bashutilities_sed "s/before/after/g" "file.txt";

function bashutilities_sed() {
    sed -i.bak "${1}" "${2}";
    rm "${2}.bak";
}

## BURY COPY
###################################

# Create path and copy
# https://stackoverflow.com/a/1534494
# EXAMPLE :
# bashutilities_bury_copy originpath/file.txt new/sub/folder/file.txt

function bashutilities_bury_copy() {
    mkdir -p `dirname $2` && cp "$1" "$2";
}

## Add after marker
###################################

# EXAMPLE :
# bashutilities_add_after_marker '##MARKER##' 'texttoinsert' file.txt
function bashutilities_add_after_marker() {
    local file_content;
    file_content=$(cat "${3}");
    file_content=${file_content//"${1}"/"${1}"$'\n'"${2}"};
    echo "${file_content}" > "${3}";
}

## Add before marker
###################################

# EXAMPLE :
# bashutilities_add_before_marker '##MARKER##' 'texttoinsert' file.txt
function bashutilities_add_before_marker() {
    local file_content;
    file_content=$(cat "${3}");
    file_content=${file_content//"${1}"/"${2}"$'\n'"${1}"};
    echo "${file_content}" > "${3}";
}

###################################
## Insert after first marker
###################################

# EXAMPLE :
# bashutilities_add_after_first_marker '##MARKER##' 'texttoinsert' file.txt
function bashutilities_add_after_first_marker() {
    local pattern=$1
    local text_to_insert=$2
    local file=$3
    local temp_file=$(mktemp)

    awk -v pattern="$pattern" -v text="$text_to_insert" '
    !found && $0 ~ pattern {
        print $0;
        print text;
        found=1;
        next
    }
    { print }' "$file" > "$temp_file" && mv "$temp_file" "$file"
}

###################################
## Insert at beginning
###################################

# EXAMPLE :
# bashutilities_insert_at_beginning 'texttoinsert' file.txt
function bashutilities_insert_at_beginning(){
    local text_to_insert="${1}";
    local file="${2}";
    echo -e "${text_to_insert}$(cat "${file}")" > "${file}";
}

###################################
## Find file in a parent folder
###################################

# EXAMPLE :
# bashutilities_find_file_in_parent_folder 'file.txt'
function bashutilities_find_file_in_parent_folder(){
    local _CURRENT_DIR=$(pwd);
    if [[ -f "${_CURRENT_DIR}/${1}" ]]; then
        echo "${_CURRENT_DIR}";
        return 0;
    fi;
    local _PARENT_DIR=$(dirname "${_CURRENT_DIR}");
    while [[ "${_PARENT_DIR}" != '/' ]]; do
        if [[ -f "${_PARENT_DIR}/${1}" ]]; then
            echo "${_PARENT_DIR}";
            return 0;
        fi;
        _PARENT_DIR=$(dirname "${_PARENT_DIR}");
    done;
    echo "";
}
