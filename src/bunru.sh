#!/bin/bash

# CONSIDER USING THE OTHER BUNRU EXECUTABLE THAT IS LOCATED IN THE "BIN/" FOLDER
# NASM BUILD AND RUNNER (BUNRU) BY DUSTGUSS
# https://github.com/DustoGuss/bunru

filename=$1
flag=$2
GREEN="\033[32m"
BLUE="\033[34m"
RED="\033[31m"
BOLD="\033[1m"
RESET="\033[0m"

build() {
    echo -e "${BOLD}${BLUE}[Compiling...]${RESET}"
    nasm -f elf64 -o "$filename.o" "$filename.asm"
    echo -e "${BOLD}${GREEN}[Compiled!]${RESET}"
    echo "----------"
    echo -e "${BOLD}${BLUE}[Linking...]${RESET}"
    ld "$filename.o" -o "$filename"
    echo -e "${BOLD}${GREEN}[Linked!]${RESET}"
        local exit_code=$? 

    if [ $exit_code -eq 0 ]; then
        echo -e "${BOLD}${GREEN}Build ended without errors! :D${RESET}"
    else
        echo -e "${BOLD}${RED}Build ended with errors... D:${RESET}"
    fi
    echo "---------"
}

run() {
    echo -e "${BOLD}${BLUE}[Running...]${RESET}"
    ./"$filename"
    local exit_code=$? 

    if [ $exit_code -eq 0 ]; then
        echo -e "${BOLD}${GREEN}Program ended without errors! :D${RESET}"
    else
        echo -e "${BOLD}${RED}Program ended with errors... D:${RESET}"
    fi
    echo "------------"
}

debug() {
    echo -e "${BOLD}${BLUE}[Debugging...]${RESET}"
    
    nasm -f elf64 -o "tempdebug$filename.o" "$filename.asm"
    ld "tempdebug$filename.o" -o "tempdebug$filename"
    local builderror=$?

    if [ $builderror -ne 0 ]; then
        echo -e "${BOLD}${RED}Debug ended with errors during build... D:${RESET}"
        return $builderror
    fi

    ./"tempdebug$filename"
    local runerror=$?

    if [ $runerror -eq 0 ]; then
        echo -e "${BOLD}${GREEN}Debug ended without errors! :D${RESET}"
    else
        echo -e "${BOLD}${RED}Debug ended with errors during execution... D:${RESET}"
    fi
    rm -f "tempdebug$filename.o" "tempdebug$filename"
}

if [ "$flag" == "-b" ]; then
    build
fi

if [ "$flag" == "-d" ]; then
    debug
fi

if [ "$flag" == "-r" ]; then
    build
    run
fi

if [ "$flag" == "-b" ] || [ "$flag" == "-r" ] || [ "$flag" == "-d" ]; then
    :
else
    echo -e "${BOLD}${RED}Invalid flag! Use -b to build, -d to debug or -r to build and run.${RESET}"
fi
