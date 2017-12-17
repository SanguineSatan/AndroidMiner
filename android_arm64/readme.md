# Android #
I have the binary setup and ready to go.

Download the app called Termux to be able to access a terminal on your device. *ROOT IS NOT NEEDED*.


## Connecting via SSH
Use this link to learn how to make a key pair to use
https://www.getfilecloud.com/blog/ssh-without-password-using-putty/

Mark down your device's IP address so you can connect to it with Putty.

~~~
apt update && apt upgrade --assume-yes
apt install openssh --assume-yes
apt install nano --assume-yes
pkg install proot --assume-yes
termuc-chroot
nano ~/.ssh/authorized_keys
~~~

Now type "ssh-rsa " and paste the public lines (as one long line) from the key you created. Save the file.

~~~
chmod 600 ~/.ssh/authorized_keys.
sshd
~~~

You should be able to connect to your android device through Putty.

## Getting to mining

```
termux-chroot
apt install git --assume-yes
git clone https://github.com/NanoBytesInc/miners.git
cd ~/miners/android_x64/
nano xmr.conf
```

Edit "xmr.conf" to reflect your pool, thread count, and username.

~~~
./miner xmr.conf
~~~

# Pool I use
Because Android CPU's are not a particularly powerful, most pools will not work very well with such low-power devices, try to use pools that provide a difficulty of less than 2,500.

Here is a good one to check out
https://moneroocean.stream

# Expected Hashrate
Give the program ~60 seconds to get all of your threads working. After about a minute the reporting will be accurate on the console. (Before this you may get results "nanH/s"). Everything is working properly during this time, the logging is just a little finicky.

#### Pixel 2XL (Snapdragon 835, 8 Cores)
* 1 Thread: ~28 H/S **(Most Efficient)**
* 2 Threads: ~22 H/S
* 3 Threads: ~26 H/S
* 4 Threads: ~30 H/S
* 6 Threads: ~40 H/S
* 8 Threads: ~44 H/S **(Highest Speed)**

[Pixel 2 XL Hashing Speeds](https://i.imgur.com/KiRqLDw.png)

#### Zenpad 3S 10 (MediaTek MT8176, 6 Cores)
* 1 Thread: ~9 H/S
* 2 Threads: ~22 H/S **(Most Efficient)**
* 4 Threads: ~22 H/S
* 6 Threads: ~28 H/S **(Highest Speed)**

[Zenpad 3S 10 Hashing Speeds](https://i.imgur.com/EH5pfg1.png)

# Compiling for yourself

* Install Termux
* Generate a key with Putty
* Figure out how to save that key onto your Android Device so that it can be copied to the clipboard.

Use this link to learn how to make a key pair to use
https://www.getfilecloud.com/blog/ssh-without-password-using-putty/


## SSH'ing into your android device
~~~
pkg update
pkg upgrade --assume-yes
pkg install openssh --assume-yes
pkg install nano --assume-yes
nano ~/.ssh/authorized_keys
~~~

Type "ssh-rsa ", paste the Putty public key from eariler.

It should look something like this
~~~
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhTGeebHIy3R02cCkiQ4eb6YUpTx9HHQDyZEZ4BORHpgN8eTmSm3OLgaaWTYmv7xiOhTXdeiswyfXYS3hdrBJH6H4ENClMkBvFYiP+a5hQl8GAiYif/V8N1yCJ6f2PIA+TIicNtSDjpltKyhqAnbkBmBTcYMuBj5D87g23sHWJul072VmkZVz/jnyfccHZjyAz2duUVPIS/Ll1fddrRA6RtmkTv0UHVHOaCZhT742AGjcPoP2KkBsQZWGNuAwkjb8Z5SA0pZUxwSiXgjBeIHd1+BFxu3RXZ9yVDLsrDHuY3dtMyqXkuyRlVa6CDY3GTZvyqc1upmjPxEUe3Ok195mDw==
~~~

* Press Volume Down + "x"
* "y"
* "enter"

This will save the file

~~~
chmod 600 ~/.ssh/authorized_keys
sshd
~~~

Now you should be able to SSH into your device. Do this. It will make this much less tedious for you :D

## Installing GCC
Termux does not come with GCC, and we need it, so lets install it

~~~
pkg install proot --assume-yes
termux-chroot
apt-get install coreutils gnupg2 apt-transport-https wget --assume-yes
mkdir $PREFIX/etc/apt/sources.list.d
echo "deb [trusted=yes] https://its-pointless.github.io/files/ termux extras" > $PREFIX/etc/apt/sources.list.d/pointless.list
wget https://its-pointless.github.io/pointless.gpg
apt-key add pointless.gpg
apt update
apt install g++ --assume-yes
apt update
apt upgrade --assume-yes
~~~

Test this by typing
~~~
gcc-6
~~~

This should report

~~~
gcc-6: fatal error: no input files
compilation terminated.
~~~

If it says something like
~~~
clang-5.0: fatal error: no input files
compilation terminated.
~~~
Then this did not work. It needs to be "gcc" doing the work.

## Installing Jansson

~~~
apt-get install automake
pkg install autoconf --assume-yes
git clone https://github.com/akheron/jansson.git
cd jansson/
autoreconf -i
./configure
make
make install
cp /usr/local/lib/libjansson.so.4  /usr/lib
cd ../
~~~

## Getting OpenCL headers
We do not need an OpenCl supported device, but we do need some headers so that the code can compile :)
We will get these from the Kronos Group

~~~
git clone https://github.com/KhronosGroup/OpenCL-Headers.git
~~~

We will need these later in the build :)

## Getting the code

~~~
pkg install git --assume-yes
git clone https://github.com/hyc/wolf-xmr-miner.git
cd wolf-xmr-miner/
git checkout armv8
~~~


## Compiling the Code
We are going to need to change a few settings in the makefile

~~~
nano M2
#Change both the compiler and linker from 'gcc' to 'gcc-6'
~~~

Save the file and exit

### Editing crypto/int-util.h
I don't know why it was not included, but we need to go into this file and include the header for endian support

In 'crypto/int-util.h', somewhere at the top of the file with the others, add
~~~
#include <endian.h>
~~~

### Editing net.c
Again, don't know why but one of the necessary header files was not included

At the top of 'net.c' add this line
~~~
#include <arpa/inet.h>
~~~

### Linking to the OpenCl headers
We need to edit the make file, so run this:
~~~
nano M2
~~~

And we will need to add an argument to the CFLAGS line. We are going to tell GCC where
to look for the OpenCL header files
~~~
-I ~/OpenCL-Headers/opencl22
~~~

This should be the directory that we installed the headers in a previous step

### Linking to Jansson
For some reason installing Jansson did not quite do the trick for me, so I had to
point GCC to the compiled (prior step) binaries by hand.

Still inside of the M2 make file, on the line that starts with `LIBS` remove `-ljansson` and replace it with
~~~
/usr/local/lib/libjansson.so
~~~

### Getting threading working
So, for some reason, again I don't know why, the function `pthread_cancel` is not implemented
on my system, so we will need to provide some function implementations.

Someone else already did the heavy lifting here, so we will just use their code

~~~
cd ~/
git clone https://github.com/tux-mind/libbthread.git
cd libbthread/
autoreconf -fi
./configure
make
cp ~/libbthread/.libs/libbthread.so.0 /usr/lib/
~~~

Now we will need to edit our make file one more time
~~~
cd ~/wolf-xmr-miner/
nano M2
~~~

On the same step where we linked to Jansson, eg, the one starting with `LIBS` we are going
to add another library. Right before the text we instered add
~~~
/home/libbthread/.libs/libbthread.so
~~~

The whole line should look like this now:
~~~
LIBS    = /home/libbthread/.libs/libbthread.so /usr/local/lib/libjansson.so  # -lOpenCL -ldl
~~~

### Finally!
~~~
make -f M2
~~~

Now you can edit the `xmr.conf` file to match you number of threads and your pool Don't worry about work size or intensity, as this build does not use the GPU.

~~~
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/miners/android_arm64/
./miner xmr.conf
~~~

To run it!

### Issues
If you have any issues be sure to let me know! Send a screenshot and I will try to help :)
