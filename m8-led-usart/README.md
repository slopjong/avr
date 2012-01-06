# ATmega8 LED blink USART test

### Circuit schematics

![schematics.png](../../raw/master/m8-led-blink/schematics.png)

### Install build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc
```

### Compile and upload main.hex

Type "make" to compile the C source code into the binary file "main.hex":

```
$ make
```

Upload main.hex to ATmega8 CPU using avrdude:

```
$ sh upload.sh
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)