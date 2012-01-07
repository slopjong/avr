# ATmega8 LED blink test

### Circuit schematics

![m8-led-blink-sch.png](../../raw/master/eagle/projects/m8-led-blink/m8-led-blink-sch.png)

A detailed description and the PCB layout can be found in the [eagle/projects/m8-led-blink](../../raw/master/eagle/projects/m8-led-blink) folder.

### Install build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc usbprog make
```

### Compile and upload main.hex

Type "make" to compile the C source code into the binary file "main.hex" and "upload.sh" to upload the main.hex file to your ATmega8 CPU using avrdude:

```
$ make && sh upload.sh
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
