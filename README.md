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

## What this project is
Hello anyone who happens to see this! This "project" is meant to be a really quick repositoyr for me so that
when I get some new device I can have it up and mining in 5 minutes; and I know that others may find these usefull
as well.

I want to make perfectly clear, I did not write the code for these, I am using `xmrig` at the moment. I did make slight 
modifications to the source code regarding `donations` and the hash rate output, but otherwise the code is the same.

## Getting started
First you need to find out what kind of processor your phone has. Google `<phone> cpu specs` and you should be able to 
see shat kind of processor your phone is using. If it says something along the lines of "32 bit" then you should go to
the `android_arm86` folder and follow the instructions. If it says something along the lines of "64 bit" then you are 
looking for the `android_arm64` folder. If your phone uses an Intel processor you should go to the `android_i686` folder.

## What coins this can mine
I have personally tested these miners with Monero (XMR) and Electorneum (ETN), but I am to understand that they whould also work
with Aeon and Sumokoin.

## Issues
Be sure to let me know if you have any issues getting this to work. I want to have this work for everyone!
