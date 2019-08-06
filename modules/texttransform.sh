#!/bin/bash

###################################
## TEXT TRANSFORMATION V 0.3.1
###################################

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

## TITLECASE
###################################

function bashutilities_titlecase(){
    sttr="${1}";
    sttr="$(tr '[:lower:]' '[:upper:]' <<< ${sttr:0:1})${sttr:1}";
    echo "${sttr}";
}
