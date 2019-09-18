#!/bin/bash


if [[ $@ =~ ^.*(-).*$ ]]; then
        count=1
        for var in "$@"
        do
                ((count++))
                if [[ $var =~ (-l) ]]; then
                        for((i=16; i<256; i++)); do
                                    printf "\e[48;5;${i}m%03d" $i;
                                            printf '\e[0m';
                                                    [ ! $((($i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n'
                                                    done
                        elif [[ $var =~ ((-h)|(--help)) ]]; then
                        echo ""
                        echo "Usage: source /tmp/`basename $0` [color-code]"
                        echo ""
                        echo "        -c [color-code] : [text color]"
                        echo "        -l : [list all color codes]"
                        echo "        -b [color-code] : [background color]"
                        echo "        -s [style] : [style of font; underline, bold, italic, strike, blink]"
                        echo ""
                        echo ""
                elif [[ $var =~ (-c) ]]; then
                        printf '\e[38;5;'${!count}'m'
                        export PS1='\e[38;5;'${!count}'m''\u@color-'${!count}'m \W\$  \e[m'
                elif [[ $var =~ (-b) ]]; then
                        printf '\e[48;5;'${!count}'m'
                        export PS1='\e[48;5;'${!count}'m''\u@color-'${!count}'m \W\$  \e[m'
                elif [[ $var =~ (-s) ]]; then
                        if [[ ${!count} =~ (bold) ]]; then
                                echo -e "\e[1m"
                        elif [[ ${!count} =~ (italic) ]]; then
                                echo -e "\e[3m"
                        elif [[ ${!count} =~ (underline) ]]; then
                                echo -e "\e[4m"
                        elif [[ ${!count} =~ (strike) ]]; then
                                echo -e "\e[9m"
                        elif [[ ${!count} =~ (blink) ]]; then
                                echo -e "\e[5;7m"
                        fi
                fi
        done
else
        echo "Not a Valid Command. Use [--help] to Find a List of Valid Commands."
        printf '\e[38;5;255m'
fi
