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
nano /.ssh/authorized_keys
~~~

Now type "ssh-rsa " and paste the public lines (as one long line) from the key you created. Save the file.

~~~
chmod 600 /.ssh/authorized_keys.
sshd
~~~

You should be able to connect to your android device through Putty.

## Getting to mining

```
termux-chroot
apt install git --assume-yes
git clone https://github.com/NanoBytesInc/miners.git
cd ~/miners/android/
nano xmr.conf
```

Edit "xmr.conf" to reflect your pool, thread count, and username.

~~~
./miner xmr.conf
~~~

Always kill the program with `pkill miner`. Though, even in those first few minutes when it says "nan" for your hash rate, it is still working fine.





# Pool I use
Because Android CPU's are not a particularly powerful, most pools will not work very well with such low-power devices, however I find that MinerGate works quite well!

URL:
stratum+tcp://xmr.pool.minergate.com:45560

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

#### Nexus Player (Intel Atom Z3560, 4 Cores)
* 1 Thread: ~9 H/S **(Most Efficient)**
* 2 Threads: ~22 H/S
* 4 Threads: ~28 H/S **(Highest Speed)**

[Zenpad 3S 10 Hashing Speeds](https://i.imgur.com/EH5pfg1.png)
