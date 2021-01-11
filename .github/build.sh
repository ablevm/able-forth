mkdir build
cd build

sudo apt-get update
sudo apt-get install bmake clang

git clone https://github.com/ablevm/libable
git clone https://github.com/ablevm/able
git clone https://github.com/ablevm/forth-scr
git clone https://github.com/ablevm/forth-img
git clone https://github.com/ablevm/able-forth

(cd libable && cp config.mk.def config.mk && bmake -DCOMPAT_LINUX && sudo bmake install)
(cd able && cp config.mk.def config.mk && bmake -DCOMPAT_LINUX && sudo bmake install)
(cd forth-scr && bmake && sudo bmake install)
(cd forth-img && bmake && sudo bmake install)

cd ..
rm -rf build

img -t forth.img 1M
scr -rns forth.scr | img -w forth.img 256B 128B
echo '." SUCCESS" cr bye' | /usr/local/able/bin/able forth.img | grep SUCCESS
