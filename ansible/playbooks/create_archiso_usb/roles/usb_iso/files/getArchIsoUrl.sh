#!/bin/bash

usage() {
    echo "Usage: $(basename $0) MODE"
    echo "Returns URL of Arch Linux iso file or sha1sums.txt file"
    echo ""
    echo "With MODE either iso, sha1 or sig"
}

getDate() {
    d=`date +%Y.%m.01`
    echo $d # 2020.03.01
}

for last; do true; done
mode=$last

ver=$(getDate)
# host_uri="https://mirror.pkgbuild.com/iso/$ver"
host_uri="http://ftp.halifax.rwth-aachen.de/archlinux/iso/$ver"
host_uri_archlinux="https://www.archlinux.org/iso/$ver"
file_archiso="archlinux-${ver}-x86_64.iso"
dir_local="file:////home/job/tmp"

if [[ $* == *--local* ]]; then
    uri=$dir_local
else
    uri=$host_uri
fi

case $mode in
    "sha1")
        echo -n ${uri}/sha1sums.txt
    ;;
    "iso")
        echo -n ${uri}/$file_archiso
    ;;
    "sig")
        echo -n ${host_uri_archlinux}/${file_archiso}.sig
    ;;
    "iso_file")
        echo -n "$file_archiso"
    ;;
    "sig_file")
        echo -n "${file_archiso}.sig"
    ;;
    *)
        echo -e "ERROR: Mode not specified or incorrect\n"
        usage
        exit 1
    ;;
esac



