#!/bin/sh

# serial bit banger
#sudo avrdude -c ponyser -P /dev/ttyUSB0 -p m8 -U main.hex

# usbprog / avrispmk2 clone
sudo avrdude -c avrispmkII -P usb       -p m8 -U main.hex
