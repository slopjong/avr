# ATmega8 USB I2C adapter SMD board

This board is very useful if you want to get started with some I2C protocol based components, e.g. temperature sensors, port expanders and flash ICs.

The board contains a 2x5-pin connector for 5V, GND, SDA, SCL and an USB type B connector. See [avr/m8-usb-i2c](../../../../tree/master/m8-usb-i2c) for the source code of the firmware for this adapter's ATmega8 CPU. The USB firmware is compatible with Till Harbaum's [usb-tiny45-i2c](http://www.harbaum.org/till/i2c_tiny_usb) board. With Linux, you do not need any extra kernel modules, as this board already has a kernel module in the vanilla Linux kernel.

### Circuit schematics

![m8-usb-i2c-smd-sch.png](../../../../raw/master/eagle/projects/m8-usb-i2c-smd/m8-usb-i2c-smd-sch.png)

### Board layout

![m8-usb-i2c-smd-brd.png](../../../../raw/master/eagle/projects/m8-usb-i2c-smd/m8-usb-i2c-smd-brd.png)

### Bill of Materials

```
Part Value            Device           Package       Description
C1   22pF             C-EUC1206        C1206         CAPACITOR, European symbol
C2   22pF             C-EUC1206        C1206         CAPACITOR, European symbol
C3   100nF            C-EUC1206        C1206         CAPACITOR, European symbol
C4   10uF             CPOL-EUSMCC      SMC_C         POLARIZED CAPACITOR, European symbol
D1   3.6v             ZENER-DIODESOT23 SOT23         Z-Diode
D2   3.6v             ZENER-DIODESOT23 SOT23         Z-Diode
I2C                   ML10             ML10          HARTING
IC1  MEGA8-AI         MEGA8-AI         TQFP32-08     MICROCONTROLLER
PWR                   LEDCHIPLED_1206  CHIPLED_1206  LED
R1   2K2              R-EU_R1206       R1206         RESISTOR, European symbol
R2   68R              R-EU_R1206       R1206         RESISTOR, European symbol
R3   68R              R-EU_R1206       R1206         RESISTOR, European symbol
R4   10K              R-EU_R1206       R1206         RESISTOR, European symbol
R5   10K              R-EU_R1206       R1206         RESISTOR, European symbol
R6   220R             R-EU_R1206       R1206         RESISTOR, European symbol
R7   10K              R-EU_R1206       R1206         RESISTOR, European symbol
U$1  AVR_MINI_PROGSMD AVR_MINI_PROGSMD AVR_MINI_PROG
X1                    PN61729          PN61729       BERG USB connector
XTAL 12MHZ            CRYSTALHC49S     HC49/S        CRYSTAL
```

*   Reichelt order list: [m8-usb-i2c-smd](http://www.reichelt.de/?ACTION=20;AWKID=525091;PROVID=2084) price: 4.26 EUR.

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
