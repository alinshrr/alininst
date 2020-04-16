#!/bin/bash

tmpdir=$1/
ver="2020.03.01"
host="https://mirror.pkgbuild.com"
uri_iso="${host}/iso/${ver}/archlinux-${ver}-x86_64.iso"
uri_sha1="${host}/iso/${ver}/sha1sums.txt"

wget -P $tmpdir $uri_iso
wget -P $tmpdir $uri_sha1



