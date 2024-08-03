#!/bin/bash

###################################
## Git v 0.4.0
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

## Commit all
###################################

function bashutilities_commit_all(){
    git add -A
    git commit --no-verify -m "${1}" --quiet;
}

## Update a repo to the latest version
###################################

function bashutilities_update_repo_to_latest_main(){
    local current_dir=$(pwd)
    cd "${1}";
    git fetch --tags;
    if [[ $(git rev-parse --abbrev-ref HEAD) != "main" ]]; then
        git checkout master;
        git checkout main;
    fi
    git pull origin --quiet;
    git submodule update --init --recursive --quiet;
    cd "${current_dir}";
}
