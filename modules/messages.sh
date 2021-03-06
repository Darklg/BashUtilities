#!/bin/bash

###################################
## MESSAGES V 0.1.2
###################################

function bashutilities_message() {
    CLR_RED='\033[31m'; # ERROR
    CLR_BLUE='\033[34m'; # NOTICE
    CLR_GREEN='\033[32m'; # SUCCESS
    CLR_YELLOW='\033[33m'; # WARNING
    CLR_DEF=' \033[0m'; # RESET

    MSG_WARN="/!\\ ${1} /!\\";
    if [[ "${3}" == 'nowarn' ]];then
        MSG_WARN="${1}";
    fi;

    case "${2}" in
        'error')
            echo -e "${CLR_RED}${MSG_WARN}${CLR_DEF}";
        ;;
        'notice')
            echo -e "${CLR_BLUE}${MSG_WARN}${CLR_DEF}";
        ;;
        'success')
            echo -e "${CLR_GREEN}${MSG_WARN}${CLR_DEF}";
        ;;
        'warning' | *)
            echo -e "${CLR_YELLOW}${MSG_WARN}${CLR_DEF}";
        ;;
    esac
}

# bashutilities_message 'Test' 'error';
# bashutilities_message 'Test' 'notice';
# bashutilities_message 'Test' 'success';
# bashutilities_message 'Test' 'warning';
