#!/bin/bash

help () {
    echo "Skript na stažení zadané stránky teletextu ČT1."
    echo "Stránka se zadá jako parametr z rozsahu 100-999[A-H]."
    echo "Např.: $0 171"
    echo "Podstránky se zadávají písmenem. Např.: 391A, 391B,..."
    echo "(Písmeno není nutné zadávat u 1. podstránky z několika.)"
    echo "Čísla podstránek jsou vypsána na posledním řádku."
    echo
    exit
}

# Reads <Tag>Content
# IFS - Input Field Separator ... words separator
# -d ... delimiter ... continue until the first character of DELIM is read, rather than newline
read_dom () { 
    local IFS=\> ;
    read -d \< Tag Content ;
}


if [ "$#" -eq 0 ] || [ "$1" = "--h" ] || [ "$1" = "--help" ]; then
    help;
fi

PatternChars=`expr match "$1" "^[1-9]\{1\}[0-9]\{2\}[A-H]\{0,1\}$"` 
if [ $PatternChars -lt 3 ] || [ $PatternChars -gt 4 ]; then
    help;
fi

# \& ... & 
wget -O /dev/shm/txtct1.html http://www.ceskatelevize.cz/teletext/ct/?ver=TXT\&page=$1 1>/dev/null 2>/dev/null

bacIFS=$IFS
IFS=
# echo $IFS | xxd
# 0000000: 0a

# Content of teletext page is stored between tags <pre> and </pre>
# Information about subpages is then stored till tag </span>. (Between <span> and </span>.)

ContentFound=0
while read_dom; do      
    #echo "Tag:  <${Tag}> ; content: ${Content}"
    if [[ ${ContentFound} -eq 1 ]]; then 
        # Information about subpages
        # Read as several chunks betwen tags:
        # "Stránka ", "176 / 2", " &ndash; podstránky: ", "1", "2"	
        [[ ${Tag} == "/span" ]] && break;
        echo -n ${Content} | sed "s/&ndash;/-/g"
    fi
    if [[ ${Tag} == "pre" ]]; then
        echo ${Content}
        ContentFound=1
    fi
done < /dev/shm/txtct1.html > /dev/shm/txtct1.txt
IFS=${bacIFS}

rm /dev/shm/txtct1.html
cat /dev/shm/txtct1.txt
rm /dev/shm/txtct1.txt

echo
