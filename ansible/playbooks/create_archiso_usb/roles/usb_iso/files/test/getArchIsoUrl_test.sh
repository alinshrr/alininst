#!/bin/bash
# tests for getArchIsoUri

set +x 

usage() {
    echo "Usage: $(basename $0)"
    echo "Runs all test for ../getArchIsoUri.sh."
}

assertEqual() {
    local func=$1
    local tobe=$2
    local ret

    ret=$($func)

    if [ $? -eq  0 ] && [ "$ret" = "$tobe" ]; then
        printf "${GREEN}TRUE${NC} \"$funcTest\"\n"
    else 
        printf "${RED}FALSE${NC} \"$funcTest\" is\n"
        printf "${RED}$ret${NC} but should be\n"
        printf "${GREEN}$tobe${NC}\n"
    fi
    printf "\n"
}

# const
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


ver="2020.03.01"
# host_uri="https://mirror.pkgbuild.com/iso/$ver"
host_uri="http://ftp.halifax.rwth-aachen.de/archlinux/iso/$ver"
host_uri_archlinux="https://www.archlinux.org/iso/$ver"
file_archiso="archlinux-${ver}-x86_64.iso"

func="../getArchIsoUrl.sh"

# Tests
funcTest="$func iso"
tobe="http://ftp.halifax.rwth-aachen.de/archlinux/iso/$ver/archlinux-$ver-x86_64.iso" 
assertEqual "$funcTest" "$tobe"

funcTest="$func --local iso"
tobe="file:////home/job/tmp/archlinux-$ver-x86_64.iso" 
assertEqual "$funcTest" "$tobe"

funcTest="$func iso_file"
tobe="archlinux-$ver-x86_64.iso" 
assertEqual "$funcTest" "$tobe"

funcTest="$func sha1"
tobe="http://ftp.halifax.rwth-aachen.de/archlinux/iso/$ver/sha1sums.txt" 
assertEqual "$funcTest" "$tobe"

funcTest="$func --local sha1"
tobe="file:////home/job/tmp/sha1sums.txt" 
assertEqual "$funcTest" "$tobe"

funcTest="$func sig"
tobe="https://www.archlinux.org/iso/$ver/archlinux-$ver-x86_64.iso.sig" 
assertEqual "$funcTest" "$tobe"

funcTest="$func --local sig"
tobe="https://www.archlinux.org/iso/$ver/archlinux-$ver-x86_64.iso.sig" 
assertEqual "$funcTest" "$tobe"

funcTest="$func sig_file"
tobe="archlinux-$ver-x86_64.iso.sig"
assertEqual "$funcTest" "$tobe"

# funcTest="$func"
# tobe="" 
# assertEqual "$funcTest" "$tobe"



# case $1 in
#     "sha1")
#         echo -n ${host_uri}/sha1sums.txt
#     ;;
#     "iso")
#         echo -n ${host_uri}/archlinux-${ver}-x86_64.iso
#         # echo -n file:////tmp/archlinux-${ver}-x86_64.iso
#     ;;
#     "sig")
#         echo -n ${host_uri_archlinux}/archlinux-${ver}-x86_64.iso.sig
#         # echo -n file:////tmp/archlinux-${ver}-x86_64.iso.sig
#     ;;
#     "")
#         echo -n 
#     *)
#         echo -e "ERROR: Mode not specified or incorrect\n"
#         usage
#         exit 1
#     ;;
# esac
