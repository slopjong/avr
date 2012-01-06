# ATmega8 rotary encoder I2C slave

### Circuit schematics

To be done..

### Install build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc
```

### Compile and upload main.hex

Type "make" to compile the C source code into the binary file "main.hex" and "upload.sh" to upload the "main.hex" file to your ATmega8 CPU using avrdude:

```
$ make && sh upload.sh
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
