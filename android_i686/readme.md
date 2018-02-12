# THIS PROJECT HAS EVOLVED INTO A FULL ANDROID APP
I have used these binaries in a full android app, and have decided to focus my developemnt efforts there.

[Pickaxe](https://github.com/NanoBytesInc/Pickaxe)

Some off-the-cuff features of the app:

* It has an OLED friendly mode
* Allows you to enter you wallet from a QR code
* The fastest mining on the market (by roughly %20 on high end phones)
* Allows you to mine to your own pools
* Can mine any CryptoNight coin, but has built in support for Monero, Electroneum, Aeon, Sumokoin, and Bytecoin (and soon to be MoneroV).
* Saves your configurations so they do not need to constantly be re-entered
* Highly stable (my 5 Android devices have been running for over a week, 24/7 without a problem)
* Works with the screen off
* Clean interface
* Shows an estimated progress in the current share
* You can un-tick the donation option

# Android (Intel i686) #
I have the binary setup and ready to go. This will only work on Android, 64 bit, Intel processors.
If you have an ARM 64 or 32 bit processor, then there is another folder in this repository for that. This only works on android 5+

Download the app called **Termux** from the app store to be able to run the program.
~~~
https://play.google.com/store/apps/details?id=com.termux&hl=en
~~~
# Getting to mining

## Getting the binaries onto your device

Enter these commands in order into the Termux terminal.
~~~
apt update
apt upgrade -y
apt install git libuv-dev -y
git clone https://github.com/NanoBytesInc/miners.git
~~~

## Setting up your config file
~~~
nano ~/miners/android_i686/config.json
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
~/miners/android_i686/xmrig
~~~

This will start mining.

This is obviously using xmrig, but I have modified the source code slightly. Here is how:

* I hardcoded the donations to `0` (because I was salty that they hardcoded a minimum of `1`)
* I corrected the output as it always showed a hash rate of `n/a`

With this miner you can use the `xmrig-proxy`.
The `xmrig-proxy` is particularly useful here because most respectable pools have difficulties that
are too high for most android devices to manage, and thus they time out. Using `xmrig-proxy` will take
that origianl large difficulty and split it up into manageable chunks for your android devices to chew on.
Though, this is not necessary of course, you can mine directly to a pool as well.

I know these pools support the `xmrig-proxy`
~~~
https://etn.spacepools.org
  Total Pool Fee: 0.1%
  Block Found: Every 10 minutes
  Minimum Difficulty: 5000
~~~

*
If you have any issues report them to me, I want this to work for everyone!
*

# Expected Hashrate

#### Nexus Player (Intel Atom Z3560, 4 Cores)
* 1 Thread: ~8 H/S **(Most Efficient)**
* 2 Threads: ~15 H/S
* 3 Threads: ~18 H/S
* 4 Threads: ~20 H/S **(Highest Speed)**

#### Nextbook Ares 8 (Intel Atom Z3735F, 4 Cores)
* 1 Thread: ~8 H/S **(Most Efficient)**
* 2 Threads: ~14 H/S
* 4 Threads: ~16 H/S
* 6 Threads: ~19 H/S **(Highest Speed)**

# Closing the miner
To close the miner, press `Volume Down + C`

# Wakelock
If you want this to mine even while your phone screen is off (to conserve power) enter
~~~
termux-wake-lock
~~~
before running the miner.

Or you can click `Aquire Wakelock` from the notification drop down.

# SSH'ing into your android device

If you SSH into your device (or use a bluetooth keyboard) this will go much more smoothly
~~~
pkg update
pkg upgrade -y
pkg install openssh -y
pkg install nano -y
nano ~/.ssh/authorized_keys
~~~

Type `ssh-rsa`, a space, then paste the Putty public key from eariler.

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

### Issues
If you have any issues be sure to let me know! Send a screenshot and I will try to help :)
