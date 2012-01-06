# ATmega8 LED blink USART test

### Circuit schematics

![schematics.png](../../raw/master/m8-led-blink/schematics.png)

### Install build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc make
```

### Compile and upload main.hex

Type "make" to compile the C source code into the binary file "main.hex" and "upload.sh" to upload the "main.hex" file to your ATmega8 CPU using avrdude:

```
$ make && sh upload.sh
```

### Remote control the ATmega8 LEDs from the command-line

Connect the RX/TX pins of the ATmega8 to an RS232 level shifter and then to an RS232 to USB dongle. The dongle should be listed as "/dev/ttyUSB0" on your Linux sytem. Next, run the following commands to remote-control the LEDs:

```
$ cd cmd
$ make
$ ./cmd # this will turn the LED1 and LED2 on and off
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
