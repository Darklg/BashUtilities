#!/bin/bash

###################################
## Submodule or install
###################################

function bashutilities_submodule_or_install(){
    local repo_git=$1
    local use_submodules=$2
    local filename=$(basename -- "$repo_git")
    local extension="${filename##*.}"
    local filename="${filename%.*}"
    if [[ "${use_submodules}" == 'y' ]]; then
        git submodule --quiet add "${repo_git}";
    else
        git clone --quiet "${repo_git}";
        rm -rf "${filename}/".git*;
    fi;
}

###################################
## Get version
###################################

function bashutilities_get_version(){
    local TAG=$(git describe --abbrev=0 --tags);
    local SEMVER_REGEX="^([0-9]*).([0-9]*).([0-9]*)$";
    if [[ "${TAG}" =~ ${SEMVER_REGEX} ]]; then
        echo "${TAG}";
    else
        echo "";
    fi;
}

