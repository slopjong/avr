## eagle HOWTOs

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

![eagle-directories.png](../avr.wiki/blob/master/img/eagle-directories.png)

### HOWTO export a bill of materials (BOM) in eagle

* run bom.ulp
* export partlist

