#!/bin/bash

###################################
## GET VALUES V 0.7.1
###################################

## EXTRACT PHP CONSTANT FROM FILE
###################################

# EXAMPLE :
# before text after
# _value=$(bashutilities_search_extract_file__php_constant "DB_HOST" "wp-config.php");

function bashutilities_search_extract_file__php_constant(){
    # Extract variable
    _variable=$(bashutilities_search_extract_file "${1}'," ");" "${2}");

    # Remove Quotes
    _first_char=${_variable:0:1};
    if [[ "${_first_char}" == "'" || "${_first_char}" == '"' ]];then
        _variable="${_variable:1}";
    fi;
    _last_char=${_variable: -1};
    if [[ "${_last_char}" == "'" || "${_last_char}" == '"' ]];then
        _variable="${_variable%?}";
    fi;

    # Return result
    echo "${_variable}";
}

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
    _variable=$(bashutilities_trim "${_variable}");
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


## GET A RANDOM STRING
###################################

# EXAMPLE :
# _myvar=$(bashutilities_rand_string 3);
# $1 : Number of chars

function bashutilities_rand_string() {
    # Initial value : current time
    _myvalue=$(date +%s%N);

    # Get wanted number of chars
    case $1 in
        ''|*[!0-9]*) _nbchar=10 ;;
        *) _nbchar=$1 ;;
    esac;

    # Use md5 if available
    if [ -x "$(command -v md5)" ]; then
        _myvalue=$(echo "${_myvalue}" | md5);
    fi
    # Use sha256sum if available
    if [ -x "$(command -v sha256sum)" ]; then
        _myvalue=$(echo "${_myvalue}" | sha256sum);
    fi

    # Cut to the desired number of chars
    _myvalue=$(echo "${_myvalue}" | head -c ${_nbchar});

    # Return value
    echo "${_myvalue}";
}

