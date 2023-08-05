#!/bin/bash

###################################
## Stop V 0.1.2
## Remove old functions
###################################

unset -f bashutilities_add_after_marker;
unset -f bashutilities_add_before_marker;
unset -f bashutilities_bury_copy;
unset -f bashutilities_commit_all;
unset -f bashutilities_get_user_var;
unset -f bashutilities_get_version;
unset -f bashutilities_get_yn;
unset -f bashutilities_launch_tests;
unset -f bashutilities_launch_tests__compare;
unset -f bashutilities_message;
unset -f bashutilities_parse_json;
unset -f bashutilities_rand_string;
unset -f bashutilities_search_extract_file;
unset -f bashutilities_search_extract_file__php_constant;
unset -f bashutilities_sed;
unset -f bashutilities_string_to_slug;
unset -f bashutilities_submodule_or_install;
unset -f bashutilities_titlecase;
unset -f bashutilities_trim;
