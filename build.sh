#!/bin/sh

set -e

img -r 1M forth.img
scr -r forth.scr | img -s 256B -i 128B forth.img
able forth.img <<EOF | grep -v "^ ok" || true
( Rebuild and install main)
: forth/  # 256 + ;
# 5 forth/ ~ load
abort
# 6 forth/ ~ load
abort
( Rebuild and install Able Forth)
: forth/  # 256 + ;
# 3 forth/ ~ load
: forth/  # 256 + ;
# 4 forth/ ~ load
bye
EOF
img -r 192B forth.img
