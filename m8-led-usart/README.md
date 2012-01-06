# ATmega8 LED blink USART test

### Circuit schematics

![schematics.png](../../raw/master/m8-led-usart/schematics.png)

### Directory contents

* cmd/              # serial cmd-line Linux tool
* schematics.png    # circuit schematics  image
* main.c            # C source code for ATmega8
* Makefile          # Makefile (also defines F_CPU and UART_BAUD)
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
