#!/bin/bash

###################################
## MESSAGES V 0.1.0
###################################

function bashutilities_message() {
    CLR_RED='\033[31m'; # ERROR
    CLR_BLUE='\033[34m'; # NOTICE
    CLR_GREEN='\033[32m'; # SUCCESS
    CLR_YELLOW='\033[33m'; # WARNING
    CLR_DEF='\033[0m'; # RESET

    case "${2}" in
        'error')
            echo -e "${CLR_RED}/!\\ ${1} /!\\ ${CLR_DEF}";
        ;;
        'notice')
            echo -e "${CLR_BLUE}/!\\ ${1} /!\\ ${CLR_DEF}";
        ;;
        'success')
            echo -e "${CLR_GREEN}/!\\ ${1} /!\\ ${CLR_DEF}";
        ;;
        'warning' | *)
            echo -e "${CLR_YELLOW}/!\\ ${1} /!\\ ${CLR_DEF}";
        ;;
    esac
}

# echo $(bashutilities_message 'Test' 'error');
# echo $(bashutilities_message 'Test' 'notice');
# echo $(bashutilities_message 'Test' 'success');
# echo $(bashutilities_message 'Test' 'warning');
