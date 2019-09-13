#!/bin/bash

if [ "$1" == "--help" ]; then
        echo ""
        echo "Usage: source /tmp/`basename $0` [color-code]"
        echo ""
        echo "        -l : [list all color codes]"
        echo "        -b [color-code] : [background color]"
        echo ""
        echo ""
elif [ "$1" == "-l" ]; then
        for((i=16; i<256; i++)); do
                    printf "\e[48;5;${i}m%03d" $i;
                        printf '\e[0m';
                            [ ! $((($i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n'
                    done
elif [[ $1 =~ ^[0-9]{3} ]]; then
        printf '\e[38;5;'$1'm'
        export PS1='\e[38;5;'$1'm''\u@color-'$1'm \W\$  \e[m'
        if [ "$2" == "-b" ]; then
                printf '\e[48;5;'$3'm'
                export PS1='\e[38;5;'$1'm''\e[48;5;'$3'm''\u@color-'$1'm \W\$  \e[m'
        fi
elif [ "$1" == "-b" ]; then
        printf '\e[48;5;'$2'm'
        export PS1='\e[48;5;'$2'm''\u@color-'$1'm \W\$  \e[m'
else
        echo "Not a Valid Command. Use [--help] to Find a List of Valid Commands."
        printf '\e[38;5;255m'
fi
