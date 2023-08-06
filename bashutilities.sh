#!/bin/bash

###################################
## Bash Utilities v 0.19.0
###################################

_SOURCEDIR_BASHUTILITIES="$( cd $(dirname "${BASH_SOURCE[0]}") && pwd )/";

###################################
## Load all modules
###################################

. "${_SOURCEDIR_BASHUTILITIES}/modules/files.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/messages.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/texttransform.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/values.sh";
. "${_SOURCEDIR_BASHUTILITIES}/modules/git.sh";

# . "${_SOURCEDIR_BASHUTILITIES}/modules/stop.sh";
