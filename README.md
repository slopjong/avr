# Koppi's and Slopjong's AVR projects

## Contents

AVR firmware source code

* ATmega8 LED blink test - [m8-led-blink](avr/tree/master/m8-led-blink)
* ATmega8 LED blink USART test - [m8-led-usart](avr/tree/master/m8-led-usart)
* ATmega8 rotary encoder I2C slave - [m8-i2c-enc](avr/tree/master/m8-i2c-enc)

AVR board schematics and layouts

* AVR ISP PIN6 adapter board - [con-isp-pin6](avr/tree/master/eagle/projects/con-isp-pin6)
* ATmega8 LED blink test boards - DIL: [m8-led-blink-dil](avr/tree/master/eagle/projects/m8-led-blink-dil), SMD: [m8-led-blink-smd](avr/tree/master/eagle/projects/m8-led-blink-smd)
* ATmega8 USB to I2C adapter board - SMD: [m8-usb-i2c-smd](avr/tree/master/eagle/projects/m8-usb-i2c-smd)
* Midi to Audio latency measurement adapter board: [midi-to-audio](avr/tree/master/eagle/projects/midi-to-audio)

## HOWTO get started

Checkout the master branch and all it's included git-submodules:

```
$ git clone --recursive git://github.com/slopjong/avr.git
```

### Install the build dependencies

On Debian/Ubuntu install the following packages:

```
$ sudo apt-get -y install avrdude gcc-avr binutils-avr avr-libc make usbprog
```

### Configure avrdude

To make avrdude work with your programmer, copy the file "avrduderc" to your home directory and adjust it to your needs:

```
$ cp avrduderc ~/.avrduderc
$ gedit ~/.avrduderc
```

### Compile all sub-projects and upload a main.hex

Simply type "make" to compile all sub-projects:

```
$ cd avr
$ make # to compile all sub-projects
```

Upload the main.hex into your AVR, eg. the ATmega8. Go to the sub-project "m8-led-blink" and run "upload.sh":

```
$ cd m8-led-blink; sh upload.sh
```

## ATMEL CPUs

### ATtiny45

![t45.png](avr/raw/master/pinouts/png/t45.png)

[ATtiny45 PDF datesheet](avr/raw/master/datasheets/t45.pdf)

### ATtiny2313

![t2313.png](avr/raw/master/pinouts/png/t2313.png)

[ATtiny2313 PDF datesheet](avr/raw/master/datasheets/t2313.pdf)

### ATmega8

![m8.png](avr/raw/master/pinouts/png/m8.png)

[ATmega8 PDF datesheet](avr/raw/master/datasheets/m8.pdf)

### ATmega32

![m32.png](avr/raw/master/pinouts/png/m32.png)

[ATmega32 PDF datesheet](avr/raw/master/datasheets/m32.pdf)

## Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
Copyright GPL 2012 by [Slopjong](https://github.com/slopjong)
