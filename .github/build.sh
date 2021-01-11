#!/bin/sh

set -e

sudo apt-get update
sudo apt-get install bmake clang

mkdir build
cd build

git clone https://github.com/ablevm/libable
git clone https://github.com/ablevm/able
git clone https://github.com/ablevm/forth-img
git clone https://github.com/ablevm/forth-scr

cd libable
cp config.mk.def config.mk
bmake -DCOMPAT_LINUX
sudo bmake install
cd ..

cd able
cp config.mk.def config.mk
bmake -DCOMPAT_LINUX
sudo bmake install
cd ..

cd forth-img
bmake
sudo bmake install
cd ..

cd forth-scr
bmake
sudo bmake install
cd ..

cd ..
rm -rf build

img -t forth.img 1M
scr -rns forth.scr | img -w forth.img 256B 128B
echo '." SUCCESS" cr bye' | /usr/local/able/bin/able forth.img | grep SUCCESS
