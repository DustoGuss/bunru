# NASM BUILD AND RUNNER (BUNRU) BY DUSTGUSS
# BUNRU SOURCE CODE
# https://github.com/DustoGuss/bunru

files=("$@")
flag="${files[-1]}"
unset 'files[-1]'
Version="1.1.0"
needflag=true
GREEN="\033[32m"
BLUE="\033[34m"
RED="\033[31m"
BOLD="\033[1m"
RESET="\033[0m"

build() {
    for file in "${files[@]}"; do
        echo -e "${BOLD}$file:${RESET}"
        echo -e "${BOLD}${BLUE}[Building $file...]${RESET}"
        if [ -f "$file.asm" ]; then
            nasm -f elf64 -o "$file.o" "$file.asm"
        else
            nasm -f elf64 -o "$file.o" "$file.s"
        fi
        echo -e "${BOLD}${GREEN}[$file builded!]${RESET}"
        echo "----------"
        echo -e "${BOLD}${BLUE}[Linking $file...]${RESET}"
        ld "$file.o" -o "$file"
        echo -e "${BOLD}${GREEN}[$file linked!]${RESET}"
        local exit_code=$? 

        if [ $exit_code -eq 0 ]; then
            echo -e "${BOLD}${GREEN}Build of $file ended without errors! :D${RESET}"
        else
            echo -e "${BOLD}${RED}Build of $file ended with errors... D:${RESET}"
        fi
        echo "---------"
    done
}

run() {
    for file in "${files[@]}"; do
        echo -e "${BOLD}$file:${RESET}"
        echo -e "${BOLD}${BLUE}[Running $file...]${RESET}"
        ./"$file"
        local exit_code=$? 

        if [ $exit_code -eq 0 ]; then
            echo -e "${BOLD}${GREEN}Program $file ended without errors! :D${RESET}"
        else
            echo -e "${BOLD}${RED}Program $file ended with errors... D:${RESET}"
        fi
        echo "------------"
    done
}

debug() {
    for file in "${files[@]}"; do
        echo -e "${BOLD}${BLUE}[Debugging $file...]${RESET}"
        
        if [ -f "$file.asm" ]; then
            nasm -f elf64 -o "tempdebug$file.o" "$file.asm"
        else
            nasm -f elf64 -o "tempdebug$file.o" "$file.s"
        fi
        ld "tempdebug$file.o" -o "tempdebug$file"
        local builderror=$?

        if [ $builderror -ne 0 ]; then
            echo -e "${BOLD}${RED}Debug of $file ended with errors during build... D:${RESET}"
            return $builderror
        fi

        ./"tempdebug$file"
        local runerror=$?

        if [ $runerror -eq 0 ]; then
            echo -e "${BOLD}${GREEN}Debug of $file ended without errors! :D${RESET}"
        else
            echo -e "${BOLD}${RED}Debug of $file ended with errors during execution... D:${RESET}"
        fi
        rm -f "tempdebug$file.o" "tempdebug$file"
    done
}

bin() {
    for file in "${files[@]}"; do
        echo -e "${BOLD}$file:${RESET}"
        echo -e "${BOLD}${BLUE}[Creating $file.bin...]${RESET}"
        if [ -f "$file.asm" ]; then
            nasm -f bin -o "$file.bin" "$file.asm"
        else
            nasm -f bin -o "$file.bin" "$file.s"
        fi
        echo -e "${BOLD}${GREEN}[$file.bin created!]${RESET}"
        local exit_code=$? 

        if [ $exit_code -eq 0 ]; then
            echo -e "${BOLD}${GREEN}Bin creation of $file ended without errors! :D${RESET}"
        else
            echo -e "${BOLD}${RED}Bin creation of $file ended with errors... D:${RESET}"
        fi
        echo "---------"
    done
}

if [ "$flag" == "-b" ]; then
    if [ $needflag == true ]; then
        build
    fi
fi

if [ "$flag" == "-d" ]; then
    if [ $needflag == true ]; then
        debug
    fi
fi

if [ "$flag" == "-r" ]; then
    if [ $needflag == true ]; then
        build
        run
    fi
fi

if [ "$flag" == "-bin" ]; then
   if [ $needflag == true ]; then

   fi 
fi

if [ "$flag" == "--v" ]; then
    needflag=false
    echo "BUNRU ${Version}"
fi

if [ "$flag" == "-b" ] || [ "$flag" == "-r" ] || [ "$flag" == "-d" ] || [ "$flag" == "--v" ] || [ "$flag" == "-bin" ]; then
    :
else
    echo -e "${BOLD}${RED}Invalid flag! Use -b to build, -d to debug or -r to build and run.${RESET}"
fi