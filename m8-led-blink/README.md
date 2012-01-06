# ATmega8 LED blink test

### Directory contents

* m8-led-blink.png  # schematic as png image
* main.c            # C source code for ATmega8
* Makefile          # Makefile 
* README.md         # this file

### Build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc
```

### Compile main.hex

Type "make" to compile the C source code into the binary file "main.hex":

```
$ make
```

### Upload to ATmega8 using avrdude

```
$ sh upload.sh
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
