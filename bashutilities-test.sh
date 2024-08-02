#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )";

. "$( dirname "${BASH_SOURCE[0]}" )/bashutilities.sh";

. "${_SOURCEDIR_BASHUTILITIES}/modules/test.sh";
bashutilities_launch_tests;

. "${_SOURCEDIR_BASHUTILITIES}/modules/stop.sh";
