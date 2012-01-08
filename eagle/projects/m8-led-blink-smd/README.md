# ATmega8 LED blink SMD test board

This is the SMD version of the ATmega8 LED blink test board. This board is very useful if you want to get started with programming AVR’s.

The board contains two LEDs, which can then be controlled in your C program. See [avr/m8-led-blink](../../../../tree/master/m8-led-blink) for the C source code "main.c".

### Circuit schematics

The board's ATmega8 is connected to the board components as follows:

* LED1 - ATmega8 PD5
* LED2 - ATmega8 PD6

![m8-led-blink-smd-sch.png](../../../../raw/master/eagle/projects/m8-led-blink-smd/m8-led-blink-smd-sch.png)

### Board layout

![m8-led-blink-smd-brd-top.png](../../../../raw/master/eagle/projects/m8-led-blink-smd/m8-led-blink-smd-brd-top.png)

![m8-led-blink-smd-brd-bot.png](../../../../raw/master/eagle/projects/m8-led-blink-smd/m8-led-blink-smd-brd-bot.png)

### Bill of Material

```
Part    Value                   Device                  Package         Description                     Sheet
IC2     MEGA8-AI                MEGA8-AI                TQFP32-08       MICROCONTROLLER                 1
ISP     AVR_ISP_SMD             AVR_ISP_SMD             AVR_ISP_SMD                                     1
LED1                            LED1206                 LED-1206        LEDs                            1
LED2                            LED1206                 LED-1206        LEDs                            1
R1      1k                      R-EU_R1206              R1206           RESISTOR, European symbol       1
R2      1k                      R-EU_R1206              R1206           RESISTOR, European symbol       1
R3      10k                     R-EU_M1206              M1206           RESISTOR, European symbol       1
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
