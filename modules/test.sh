#!/bin/bash

###################################
## Test V 0.1.1
## Test functions
###################################

function bashutilities_launch_tests(){
    local _test_str;
    local _test_str_control;

    # SED
    echo 'loremipsum' > "test-file.txt";
    bashutilities_sed "s/ipsum/test/g" "test-file.txt";
    _test_str=$(cat "test-file.txt");
    if [[ "${_test_str}" != 'loremtest' ]];then
        echo "- bashutilities_sed does not work";
        exit 1;
    else
        echo "- bashutilities_sed seems to work fine";
    fi;
    rm "test-file.txt";

    # MARKERS
    cp "${_SOURCEDIR_BASHUTILITIES}/tests/markers-before.txt" "tests-markers-before.txt";
    bashutilities_add_after_marker '##MARKER##' 'facto' "tests-markers-before.txt";
    bashutilities_add_after_marker '##MARKER##' 'ipsum' "tests-markers-before.txt";
    bashutilities_add_before_marker '##MARKER##' 'lorem' "tests-markers-before.txt";
    bashutilities_sed "s/##MARKER##//g"  "tests-markers-before.txt";
    _test_str=$(cat "tests-markers-before.txt");
    _test_str_control=$(cat "${_SOURCEDIR_BASHUTILITIES}/tests/markers-after.txt");
    if [[ "${_test_str}" != "${_test_str_control}" ]];then
        echo "- bashutilities markers does not work";
        exit 1;
    else
        echo "- bashutilities markers seems to work fine";
    fi;
    rm "tests-markers-before.txt";

}
