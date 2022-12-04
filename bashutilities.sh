#!/bin/bash

###################################
## Bash Utilities v 0.16.1
###################################

_SOURCEDIR_BASHUTILITIES="$( dirname "${BASH_SOURCE[0]}" )/";

###################################
## Load all modules
###################################

. "${_SOURCEDIR_BASHUTILITIES}/modules/files.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/messages.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/texttransform.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/values.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/git.sh";

# . "${_SOURCEDIR_BASHUTILITIES}/modules/stop.sh";
