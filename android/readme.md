# Android #
I have the binary setup and ready to go.

Download the app called Termux to be able to access a terminal on your device. *ROOT IS NOT NEEDED*.

TODO: Add a tutorial for how to get SSH working with Putty on windows

## Getting to mining


```
apt install git
git clone https://github.com/NanoBytesInc/miners.git
cd ~/miner/android/
```

Edit "xmr.conf" to reflect your pool, thread count, and username. Then use `./miner xmr.conf` to start mining.

If you kill the program with Ctrl+C, this will, because reasons, make the console printing seem a little off for a few minutes. If you dont want this, always kill the program with `pkill miner`. Though, even in those first few minutes when it says "nan" for your hash rate, it is still working fine.





# Pool I use
Because Android CPU's are not a particularly powerful, most pools will not work very well with such low-power devices, however I find that MinerGate works quite well!

URL:
stratum+tcp://xmr.pool.minergate.com:45560

# Expected Hashrate
Give the program ~60 seconds to get all of your threads working. After about a minute the reporting will be accurate on the console. (Before this you may get results "nanH/s"). Everything is working properly during this time, the logging is just a little finicky.

#### Pixel 2XL (Snapdragon 835)
* 1 Thread: ~28 H/S **(Most Efficient)**
* 2 Threads: ~22 H/S
* 3 Threads: ~26 H/S
* 4 Threads: ~30 H/S
* 6 Threads: ~40 H/S
* 8 Threads: ~44 H/S **(Highest Speed)**



### Pixel 2 Xl (Snapdragon 835)

 I am getting somewhere around 43 h/s
[Imgur](https://i.imgur.com/KiRqLDw.png)
