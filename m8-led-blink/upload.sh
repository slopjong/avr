#!/bin/sh

# Configure avrdude via ~/.avrduderc !
#
# default_programmer = "avrispmkII";
# default_serial = "usb";

sudo avrdude -p m8 -U main.hex
