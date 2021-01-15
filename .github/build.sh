#!/bin/sh

set -e

case "$1" in
	ubuntu-*)
		export COMPAT_LINUX=

		sudo apt-get update
		sudo apt-get install bmake clang
		;;
	macos-*)
		export COMPAT_MACOS=

		brew update
		brew install bmake
		;;
esac

mkdir build
cd build

git clone https://github.com/ablevm/libable
git clone https://github.com/ablevm/able
git clone https://github.com/ablevm/forth-img
git clone https://github.com/ablevm/forth-scr

cd libable
cp config.mk.def config.mk
bmake
sudo bmake install
cd ..

cd able
cp config.mk.def config.mk
bmake
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
echo '." SUCCESS" cr bye' | able forth.img | grep SUCCESS
