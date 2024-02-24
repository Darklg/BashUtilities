#!/bin/bash

###################################
## TEXT TRANSFORMATION V 0.5.0
###################################

## STRING TO SLUG
###################################

# EXAMPLE :
# _slug=$(bashutilities_string_to_slug "Kévin");

function bashutilities_string_to_slug() {
    local _slug;
    _slug="$(echo -e "${1}" | tr -d '[[:space:]]' | tr [:upper:] [:lower:])";
    _slug="$(echo ${_slug} | iconv -s -f utf8 -t ascii//TRANSLIT)";
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

## Version Bump
###################################

function bashutilities_version_bump() {
    local _version="${1}"
    local _upgrade_type="${2}"

    # Split version
    local _version_part_major=$(echo "${_version}" | cut -d "." -f 1)
    local _version_part_minor=$(echo "${_version}" | cut -d "." -f 2)
    local _version_part_patch=$(echo "${_version}" | cut -d "." -f 3)

    # Upgrade Increment part
    if [[ "${_upgrade_type}" == 'major' ]]; then
        _version_part_major=$((_version_part_major + 1))
        _version_part_minor="0";
        _version_part_patch="0";
    fi
    if [[ "${_upgrade_type}" == 'minor' ]]; then
        _version_part_minor=$((_version_part_minor + 1))
        _version_part_patch="0";
    fi
    if [[ "${_upgrade_type}" == 'patch' ]]; then
        _version_part_patch=$((_version_part_patch + 1))
    fi
    echo "${_version_part_major}.${_version_part_minor}.${_version_part_patch}"
}
