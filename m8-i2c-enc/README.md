# ATmega8 I2C rotary encoder test

### Circuit schematics

To be done..

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

Upload main.hex to the ATmega8 CPU using avrdude

```
$ sh upload.sh
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)