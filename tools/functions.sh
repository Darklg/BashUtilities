#!/bin/bash

###################################
## FUNCTIONS V 0.2.0
###################################

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

## SED FOR LINUX / OSX
###################################

# EXAMPLE :
# bashutilities_sed "s/before/after/g" "file.txt";

function bashutilities_sed() {
    sed -i.bak "${1}" "${2}";
    rm "${2}.bak";
}

## STRING TO SLUG
###################################

# EXAMPLE :
# _slug=$(bashutilities_string_to_slug "Kévin");

function bashutilities_string_to_slug() {
    _slug="$(echo -e "${1}" | tr -d '[[:space:]]' | tr [:upper:] [:lower:])";
    _slug="$(echo ${_slug} | iconv -f utf8 -t ascii//TRANSLIT)";
    _slug="$(echo ${_slug} | tr -cd '[[:alnum:]]._-')";
    echo "${_slug}";
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
