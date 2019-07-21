#!/bin/bash

###################################
## FILES V 0.3.0
###################################

## SED FOR LINUX / OSX
###################################

# EXAMPLE :
# bashutilities_sed "s/before/after/g" "file.txt";

function bashutilities_sed() {
    sed -i.bak "${1}" "${2}";
    rm "${2}.bak";
}

## BURY COPY
###################################

# Create path and copy
# https://stackoverflow.com/a/1534494
# EXAMPLE :
# bashutilities_bury_copy originpath/file.txt new/sub/folder/file.txt

function bashutilities_bury_copy() {
    mkdir -p `dirname $2` && cp "$1" "$2";
}
