cd ~

# Installing CLANG
apt update
apt upgrade -y
apt install clang

# Installing Jansson
apt-get install git automake libtool -y
pkg install autoconf -y
git clone https://github.com/akheron/jansson.git
cd jansson/
autoreconf -i
./configure
make
make install
cp /usr/local/lib/libjansson.so.4  /usr/lib
cd ~

# Installing the threading library
git clone https://github.com/tux-mind/libbthread.git
cd libbthread/
autoreconf -i
./configure
make
cp ~/libbthread/.libs/libbthread.so.0 /usr/lib/
cd ~

# Getting OpenCL headers
git clone https://github.com/KhronosGroup/OpenCL-Headers.git

# Getting the original source code
git clone https://github.com/hyc/wolf-xmr-miner.git
cd wolf-xmr-miner/
git checkout armv8

# Editing crypto/int-util.h
sed -i '1s/^/#include <endian.h>\n/' crypto/int-util.h

# Editing net.c
sed -i '1s/^/#include <arpa\/inet.h>\n/' net.c

# Editing main.c
sed '1773,1783d' main.c > main.tmp
cp main.tmp main.c
sed '1774,1774d' main.c > main.tmp
cp main.tmp main.c

# Editing cryptonight.c
sed '216,216d' cryptonight.c > cryptonight.tmp
cp cryptonight.tmp cryptonight.c

sed '146,146d' cryptonight.c > cryptonight.tmp
cp cryptonight.tmp cryptonight.c

sed '124,124d' cryptonight.c > cryptonight.tmp
cp cryptonight.tmp cryptonight.c

sed '97,97d' cryptonight.c > cryptonight.tmp
cp cryptonight.tmp cryptonight.c

sed '91,95d' cryptonight.c > cryptonight.tmp
cp cryptonight.tmp cryptonight.c

sed '78,78d' cryptonight.c > cryptonight.tmp
cp cryptonight.tmp cryptonight.c

# Editing crypto/oaes_lib.c
sed '38,38d' crypto/oaes_lib.c > crypto/oaes_lib.tmp
cp crypto/oaes_lib.tmp crypto/oaes_lib.c
sed -i '38s/^/struct timeb {time_t time;short millitm;short timezone;short dstflag;};int ftime(struct timeb *);\n/' crypto/oaes_lib.c

# Adding x86 code to the makefile
sed -i '/cryptonight.o log.o net.o minerutils.o main.o/d' ./M2
sed -i '10s/^/\tcrypto\/aesb.o crypto\/oaes_lib.o crypto\/aesb-x86-impl.o cryptonight.o log.o net.o minerutils.o main.o\n/' M2

# Including the OpenCl headers
sed -i '/CFLAGS/d' ./M2
sed -i '1s/^/CFLAGS  = -D_POSIX_SOURCE -D_GNU_SOURCE -O3 -pthread -c -std=c11 -march=armv8-a+crypto -I ~\/OpenCL-Headers\/opencl22\n/' M2

# Linking to Jansson and the Threading Library
sed -i '/LIBS\t=/d' ./M2
sed -i '1s/^/LIBS    = \/home\/libbthread\/.libs\/libbthread.so \/usr\/local\/lib\/libjansson.so\n/' M2

# Finaly
make -f M2
