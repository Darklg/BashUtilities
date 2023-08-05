#!/bin/bash

###################################
## Test V 0.2.0
###################################

bashutilities_launch_tests__compare(){
    if [[ "${1}" != "${2}" ]];then
        echo "- ${3} does not work";
        echo "Value 1 : ''${1}''";
        echo "Value 2 : ''${2}''";
        exit 1;
    else
        echo "- ${3} seems to work fine";
    fi;
}

function bashutilities_launch_tests(){
    local _test_str;
    local _test_str_control;
    local _test_file;

    # SED
    echo 'loremipsum' > "test-file.txt";
    bashutilities_sed "s/ipsum/test/g" "test-file.txt";
    _test_str=$(cat "test-file.txt");
    bashutilities_launch_tests__compare "${_test_str}" "loremtest" "bashutilities_sed";
    rm "test-file.txt";

    # MARKERS
    _test_file="tests-markers-before.txt";
    cp "${_SOURCEDIR_BASHUTILITIES}/tests/markers-before.txt" "${_test_file}";
    bashutilities_add_after_marker '##MARKER##' 'facto' "${_test_file}";
    bashutilities_add_after_marker '##MARKER##' 'ipsum' "${_test_file}";
    bashutilities_add_before_marker '##MARKER##' 'lorem' "${_test_file}";
    bashutilities_sed "s/##MARKER##//g"  "${_test_file}";
    _test_str=$(cat "${_test_file}");
    _test_str_control=$(cat "${_SOURCEDIR_BASHUTILITIES}/tests/markers-after.txt");
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities markers";
    rm "tests-markers-before.txt";

    # SLUG
    _test_str=$(bashutilities_string_to_slug "KéviN");
    _test_str_control="kevin";
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_string_to_slug";

    # TITLECASE
    _test_str_control="Kevin kevin";
    _test_str=$(bashutilities_titlecase "kevin kevin");
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_titlecase";

    # TRIM
    _test_str_control="kevin";
    _test_str=$(bashutilities_trim "  kevin  ");
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_trim #1";
    _test_str=$(bashutilities_trim "kevin  ");
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_trim #2";
    _test_str=$(bashutilities_trim "  kevin");
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_trim #3";

    # JSON
    _test_str_control="ok";
    _test_str=$(bashutilities_parse_json '{"test":"ok","value":"nok"}' 'test');
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_parse_json";

    # Extract from file
    _test_file="${_SOURCEDIR_BASHUTILITIES}/tests/search-file.txt";
    _test_str=$(bashutilities_search_extract_file "Version: " "" "${_test_file}" );
    _test_str_control="0.1.0"
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_search_extract_file #1";
    _test_str=$(bashutilities_search_extract_file "namespace " ";" "${_test_file}" );
    _test_str_control="test"
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_search_extract_file #2";

    # Extract from PHP
    _test_file="${_SOURCEDIR_BASHUTILITIES}/tests/search-file.php";
    _test_str_control="lorem"
    _test_str=$(bashutilities_search_extract_file__php_constant "PWET_TEST" "${_test_file}" );
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_search_extract_file__php_constant #1";
    _test_str=$(bashutilities_search_extract_file__php_constant "PWET_TEST_DEMO" "${_test_file}" );
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_search_extract_file__php_constant #2";
    _test_str=$(bashutilities_search_extract_file__php_constant "PWET_TEST_DEMO2" "${_test_file}" );
    bashutilities_launch_tests__compare "${_test_str}" "${_test_str_control}" "bashutilities_search_extract_file__php_constant #3";

}
