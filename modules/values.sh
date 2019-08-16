#!/bin/bash

###################################
## GET VALUES V 0.5.0
###################################

###################################
## SEARCH AND EXTRACT FROM FILE
###################################

# EXAMPLE :
# before text after
# _value=$(bashutilities_search_extract_file "before" "after" "values.sh");

function bashutilities_search_extract_file(){
    # Get first line containing the two items
    _variable=$(sed "/$1/,/$2/!d;/$2/q" $3);
    # Cut until first part
    _variable=${_variable##*$1};
    # Remove last part
    _variable=${_variable/$2/};
    # Trim result
    _variable="$(echo -e "${_variable}" | tr '\n' ' ')";
    _variable="${_variable// /}";
    # Return result
    echo "${_variable}";
}

## PARSE JSON
###################################

# Thanks to http://stackoverflow.com/a/26655887
# EXAMPLE :
# _value=$(bashutilities_parse_json '{"test":"ok","value":"nok"}' 'test');

function bashutilities_parse_json() {
    echo "${1}" | \
    sed -e 's/[{}]/''/g' | \
    sed -e 's/", "/'\",\"'/g' | \
    sed -e 's/" ,"/'\",\"'/g' | \
    sed -e 's/" , "/'\",\"'/g' | \
    sed -e 's/","/'\"---SEPARATOR---\"'/g' | \
    awk -F=':' -v RS='---SEPARATOR---' "\$1~/\"$2\"/ {print}" | \
    sed -e "s/\"$2\"://" | \
    tr -d "\n\t" | \
    sed -e 's/\\"/"/g' | \
    sed -e 's/\\\\/\\/g' | \
    sed -e 's/^[ \t]*//g' | \
    sed -e 's/^"//'  -e 's/"$//'
}

## GET USER VAR Y / N
###################################

# EXAMPLE :
# _myvaractive=$(bashutilities_get_yn "- Is it active?" 'n');
# $1 : Question
# $2 : Default value
function bashutilities_get_yn() {
    default_choice="[Y/n]";
    if [[ ${2} == 'n' ]]; then
        default_choice="[y/N]";
    fi;
    while true; do
        read -p "${1} ${default_choice} : " yn
        case $yn in
            [1YyOo]* ) yn="y"; break;;
            [0Nn]* ) yn="n"; break;;
            * ) yn=${2}; break;;
        esac
    done
    echo "${yn}";
}

## GET USER VAR
###################################

# EXAMPLE :
# _myvar=$(bashutilities_get_user_var "- What is your var?" "default");
# $1 : Question
# $2 : Default value
function bashutilities_get_user_var() {
    _myvalue="${2}";
    read -p "${1} [${2}] : " _myvalue;
    if [[ "${_myvalue}" == '' ]]; then
        _myvalue="${2}";
    fi;
    echo "${_myvalue}";
}
