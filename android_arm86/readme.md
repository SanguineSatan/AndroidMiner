# Android (ARM x86) #
I have the binary setup and ready to go. This will only work on Android, 32 bit, ARM processors.
If you have an Intel processor, or an ARM 64 bit processor, then there is another folder in this repository for that. This only works on android 5+

Download the app called **Termux** from the app store to be able to run the program.
~~~
https://play.google.com/store/apps/details?id=com.termux&hl=en
~~~
# Getting to mining

## Getting the binaries onto your device

Enter these commands in order into the Termux terminal.
~~~
apt install git -y
git clone https://github.com/NanoBytesInc/miners.git
~~~

## Setting up your config file
~~~
nano ~/miners/android_arm86/config.json
~~~

This is where things get a little scary for anyone new to mining, so I will try to be as detailed
as possible. There are only three fields you will (probably) need to change to get started. These are the `threads`, `url`, and `user` fields. Everything else can be left the same.

* `threads`: This is how many cores you have on your devices
* `url`: This is the URL of the pool you want to mine on (discussed later)
* `user`: This is pool specific, and it may be your wallet address, or it may be your login username. Check the specific pool's instructions on what username to use for your miners.

If you are using a Bluetooth keyboard, or are SSH'd into your device then editing the config.json file should be straight forward. However, if you are using just your phone with the touch keyboard then it becomes slightly more complicated. Here is how to do it.

**To move the cursor**

~~~
Volume Up + W,A,S,D; this is to go up, left, down, and right respectively.
~~~

**Then, once the file has been edited, press**
~~~
Volume Down + X to "save and exit". Hit y to confirm the save, and then push enter!
~~~

The file should be save at this point! You should be ready to mine!

## Running the miner
~~~
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/miners/android_arm86/
cd ~/miners/android_arm86/
./miner config.json
~~~

This will start mining. I have set the binary to only display your hash rate once a share is submitted. So have a little bit of patience when you first run the program. Your speeds will be displayed soon enough. :D If the first couple times it displays as "nanH/s" don't worry, it is still working fine, just give it time!

*
If you have any issues report them to me, I want this to work for everyone!
*

# Expected Hashrate
Give the program ~60 seconds to get all of your threads working. After about a minute the reporting will be accurate on the console. (Before this you may get results "nanH/s"). Everything is working properly during this time, the logging is just a little finicky.

#### ... (..., ... Cores)
* 1 Thread: ~28 H/S **(Most Efficient)**
* 2 Threads: ~22 H/S
* 3 Threads: ~26 H/S
* 4 Threads: ~30 H/S **(Highest Speed)**

[...](...)

# SSH'ing into your android device

If you SSH into your device (or use a bluetooth keyboard) this will go much more smoothly
~~~
pkg update
pkg upgrade -y
pkg install openssh -y
pkg install nano -y
nano ~/.ssh/authorized_keys
~~~

Type "ssh-rsa ", paste the Putty public key from eariler.

It should look something like this
~~~
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhTGeebHIy3R02cCkiQ4eb6YUpTx9HHQDyZEZ4BORHpgN8eTmSm3OLgaaWTYmv7xiOhTXdeiswyfXYS3hdrBJH6H4ENClMkBvFYiP+a5hQl8GAiYif/V8N1yCJ6f2PIA+TIicNtSDjpltKyhqAnbkBmBTcYMuBj5D87g23sHWJul072VmkZVz/jnyfccHZjyAz2duUVPIS/Ll1fddrRA6RtmkTv0UHVHOaCZhT742AGjcPoP2KkBsQZWGNuAwkjb8Z5SA0pZUxwSiXgjBeIHd1+BFxu3RXZ9yVDLsrDHuY3dtMyqXkuyRlVa6CDY3GTZvyqc1upmjPxEUe3Ok195mDw==
~~~

Then to save the file:
~~~
Press Volume Down + 'x' to "save as". Then press 'y' and then enter!
~~~

Then type
~~~
chmod 600 ~/.ssh/authorized_keys
sshd
~~~

Now you should be able to SSH into your device. Do this. It will make this much less tedious for you :D

# Compiling for yourself

## Using my pre-built script
This is just the aggregation of all of the steps below

<>

The final binary will be: ``~/wolf-xmr-miner/miner`

## By hand

* **Install Termux** from the app store
* Generate a key with Putty
* Figure out how to save that key onto your Android Device so that it can be copied to the clipboard.

Use this link to learn how to make a key pair to use
https://www.getfilecloud.com/blog/ssh-without-password-using-putty/


## Installing CLANG
We need a compiler on Termux

~~~
apt update
apt upgrade -y
apt install clang
~~~


## Installing Jansson

~~~
apt-get install git automake libtool -y
pkg install autoconf -y
git clone https://github.com/akheron/jansson.git
cd jansson/
autoreconf -i
./configure
make
make install
cp /usr/local/lib/libjansson.so.4  /usr/lib
cd ../
~~~

## Installing the threading library
So, for some reason, again I don't know why, the function `pthread_cancel` is not implemented
on my system, so we will need to provide some function implementations.

Someone else already did the heavy lifting here, so we will just use their code

~~~
git clone https://github.com/tux-mind/libbthread.git
cd libbthread/
autoreconf -i
./configure
make
cp ~/libbthread/.libs/libbthread.so.0 /usr/lib/
cd ../
~~~


## Getting OpenCL headers
We do not need an OpenCl supported device, but we do need some headers so that the code can compile :)
We will get these from the Kronos Group

~~~
git clone https://github.com/KhronosGroup/OpenCL-Headers.git
~~~

We will need these later in the build :)

## Getting the original source code

~~~
git clone https://github.com/hyc/wolf-xmr-miner.git
cd wolf-xmr-miner/
git checkout armv8
~~~


## Editing the Code
We are going to need to make a few changes to the source code to be able to make it compile

** Editing crypto/int-util.h **

I don't know why it was not included, but we need to go into this file and include the header for endian support

~~~
sed -i '1s/^/#include <endian.h>\n/' crypto/int-util.h
~~~

** Editing net.c **

Again, don't know why but one of the necessary header files was not included

~~~
sed -i '1s/^/#include <arpa\/inet.h>\n/' net.c
~~~

**Editing main.c **

We need to change the code a little bit so that this will work with 32 bit devices.

~~~
sed '1773,1783d' main.c > main.tmp
cp main.tmp main.c
sed '1774,1774d' main.c > main.tmp
cp main.tmp main.c
~~~

**Editing cryptonight.c**

We need to change the code a little bit so that this will work with 32 bit devices.

~~~
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
~~~

**Editing crypto/oaes_lib.c**

for some reason this code uses an old library called 'sys/timeb.h' which is not included anymore. So we will need to add its code to the project

~~~
sed '38,38d' crypto/oaes_lib.c > crypto/oaes_lib.tmp
cp crypto/oaes_lib.tmp crypto/oaes_lib.c
sed -i '38s/^/struct timeb {time_t time;short millitm;short timezone;short dstflag;};int ftime(struct timeb *);\n/' crypto/oaes_lib.c
~~~


## Adding x86 code to the makefile
~~~
sed -i '/cryptonight.o log.o net.o minerutils.o main.o/d' ./M2
sed -i '10s/^/\tcrypto\/aesb.o crypto\/oaes_lib.o crypto\/aesb-x86-impl.o cryptonight.o log.o net.o minerutils.o main.o\n/' M2
~~~

## Including the OpenCl headers

We need to edit the make file, so run this:
~~~
sed -i '/CFLAGS/d' ./M2
sed -i '1s/^/CFLAGS  = -D_POSIX_SOURCE -D_GNU_SOURCE -O3 -pthread -c -std=c11 -march=armv8-a+crypto -I ~\/OpenCL-Headers\/opencl22\n/' M2
~~~

This should tell the compiler to look for the CL headers in the location we cloned them into earlier.

## Linking to Jansson and the Threading Library

For some reason installing Jansson did not quite do the trick for me, so I had to
point GCC to the compiled (prior step) binaries by hand.

~~~
sed -i '/LIBS    =/d' ./M2
sed -i '1s/^/LIBS    = \/home\/libbthread\/.libs\/libbthread.so \/usr\/local\/lib\/libjansson.so\n/' M2
~~~

## Finally!
~~~
make -f M2
~~~

Now you can edit the `xmr.conf` file to match you number of threads and your pool Don't worry about work size or intensity, as this build does not use the GPU.

~~~
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/miners/android_arm86/
./miner xmr.conf
~~~

To run it!

### Issues
If you have any issues be sure to let me know! Send a screenshot and I will try to help :)
