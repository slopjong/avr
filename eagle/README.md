## Eagle HOWTOs

### HOWTO install Eagle and EDA tools on Ubuntu 11.10

```
$ sudo apt-get -y install eagle gerbv openjdk-6-jdk
```

### HOWTO setup the ~/eagle directory with the avr repository

Go to your home directory and add a symbolic link to the avr/eagle directory:

```
$ cd # go to the home directory
$ ln -fvs path/to/avr/eagle # create symbolic link in the home directory
```

Next, start eagle and adjust the directories by going to Menu: Options -> Directories...:

```
$ eagle
```

Setup the eagle directories as follows. Add the "$HOME/eagle/..." paths to "Libraries", "Design Rules", "User Language Programs", "Scripts", "CAM Jobs", "Projects" as shown in the following image:

![eagle-directories.png](../../wiki/img/eagle-directories.png)

### HOWTO export a bill of materials (BOM) in eagle

* run bom.ulp
* export partlist

### HOWTO auto-route your PCB with FreeRouting

[FreeRouting](http://www.freerouting.net/) is a printed circuit board routing software. The speed of the FreeRouting autorouter is still a bit slow, but the quality of the routing results is very good when compared with the results of the Eagle autorouter.

First install Java 1.6:

```
$ sudo apt-get -y install openjdk-6-jdk
```

Next, convert the Eagle brd file into a dsn file for the FreeRouting autorouter. Open the ulp script "[brd_to_dsn.ulp](http://www.freerouting.net/download/brd_to_dsn.ulp)" with your Eagle brd layout, the latest version of this script is available at [http://www.freerouting.net/index.php?page=eagle](http://www.freerouting.net/index.php?page=eagle) and save the dsn file into your eagle project directory.

Next, start FreeRouting either from your browser or on the terminal:

```
$ javaws http://www.freerouting.net/java/freeroute.jnlp
```

Run the AutoRouter and save as an Eagle SCR script. Next, open the script in the Eagle board layouter.

### HOWTO create gerber files in Eagle

In Eagle go to "File -> Cam Processor ..". In the Cam Processor go to "File -> Open -> Job.." and select "eagle/ulp/gerb274x.cam". Next, click on "Process Job" and you're done.

### HOWTO git sub-modules

The eagle directory contains the following git sub-modules:

*   eagle/lbr/sparkfun-git: SparkFun Eagle Footprint Library:

    git://github.com/sparkfun/SparkFun-Eagle-Library.git

*   eagle/lbr/adafruit-git: Adafruit Eagle Footprint Library:

    git://github.com/adafruit/Adafruit-Eagle-Library.git
