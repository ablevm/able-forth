#!/bin/sh

img -t forth.img 1M
scr -r forth.scr | img -w forth.img 256B 128B
able forth.img <<EOF
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
img -t forth.img 192B
