# Koppi's AVR projects

## Contents

* [m8-led-blink](avr/tree/master/m8-led-blink) - ATmega8 LED blink test
* [m8-led-usart](avr/tree/master/m8-led-usart) - ATmega8 LED blink USART test
* [m8-i2c-enc](avr/tree/master/m8-i2c-enc)   - ATmega8 I2C rotary encoder

## HOWTO get started

Checkout the master branch:

```
$ git co git://github.com/koppi/avr.git
```

### Install the build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc           
```

### Compile all sub-projects

Simply type "make" to compile all sub-projects:

```
$ cd avr
$ make # to compile all sub-projects
```

### Configure avrdude

To make avrdude work with your programmer, copy the file "avrduderc" to your home directory and adjust it to your needs:

```
$ cp avrduderc ~/.avrduderc
$ gedit avrduderc
```

### Program the main.hex into your AVR

Go to the sub-project and run "upload.sh":

```
$ cd m8-led-blink; sh upload.sh
```

## ATMEL CPUs

### ATtiny45

![t45.png](avr/raw/master/t45.png)

[ATtiny45 datesheet - t45.pdf](avr/raw/master/t45.pdf)

### ATtiny2313

![t2313.png](avr/raw/master/t2313.png)

[ATtiny2313 datesheet - t2313.pdf](avr/raw/master/t2313.pdf)

### ATmega8

![m8.png](avr/raw/master/m8.png)

[ATmega8 datesheet - m8.pdf](avr/raw/master/m8.pdf)

### ATmega32

![m32.png](avr/raw/master/m32.png)

[ATmega32 datesheet - m32.pdf](avr/raw/master/m32.pdf)

## Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)

