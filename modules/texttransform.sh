#!/bin/bash

###################################
## TEXT TRANSFORMATION V 0.4.2
###################################

## STRING TO SLUG
###################################

# EXAMPLE :
# _slug=$(bashutilities_string_to_slug "Kévin");

function bashutilities_string_to_slug() {
    local _slug;
    _slug="$(echo -e "${1}" | tr -d '[[:space:]]' | tr [:upper:] [:lower:])";
    _slug="$(echo ${_slug} | iconv -f utf8 -t ascii//TRANSLIT)";
    _slug="$(echo ${_slug} | tr -cd '[[:alnum:]]._-')";
    echo "${_slug}";
}

## TITLECASE
###################################

function bashutilities_titlecase(){
    local sttr="${1}";
    echo "$(tr '[:lower:]' '[:upper:]' <<< ${sttr:0:1})${sttr:1}";
}

## TRIM
###################################
# Thx to https://stackoverflow.com/a/3352015

# EXAMPLE :
# _slug=$(bashutilities_trim "  kevin  ");

function bashutilities_trim(){
    local _variable="${1}";
    # Remove line breaks & tabs
    _variable="$(echo -e "${_variable}" | tr '\t' ' ')";
    _variable="$(echo -e "${_variable}" | tr '\n' ' ')";
    _variable="$(echo -e "${_variable}" | tr '\r' ' ')";
    # remove leading whitespace characters
    _variable="${_variable#"${_variable%%[![:space:]]*}"}";
    # remove trailing whitespace characters
    _variable="${_variable%"${_variable##*[![:space:]]}"}";
    echo "${_variable}";
}

