#!/bin/bash

###################################
## Bash Utilities v 0.8.0
###################################

_SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";

###################################
## Load all modules
###################################

. "${_SOURCEDIR}/modules/files.sh";
. "${_SOURCEDIR}/modules/messages.sh";
. "${_SOURCEDIR}/modules/texttransform.sh";
. "${_SOURCEDIR}/modules/values.sh";
