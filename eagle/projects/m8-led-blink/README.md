# ATmega8 LED blink test board

This board is very useful if you want to get started with programming AVR’s.

The board contains two LEDs, which can then be controlled in your C program. See [avr/m8-led-blink](../../../../raw/master/m8-led-blink) for the C source code "main.c".

### Circuit schematics

The board's ATmega8 is connected to the board components as follows:

* LED1 - ATmega8 PD5
* LED2 - ATmega8 PD6

![m8-led-blink-sch.png](../../../../raw/master/eagle/projects/m8-led-blink/m8-led-blink-sch.png)

### Board layout

![m8-led-blink-brd.png](../../../../raw/master/eagle/projects/m8-led-blink/m8-led-blink-brd.png)

### Bill of Material

```
Part     Value   Device       Package Description
IC1      MEGA8-P MEGA8-P      DIL28-3 MICROCONTROLLER
ISP_PIN6         PINHD-1X6    1X06    PIN HEADER
LED1             LED3MM-RED   LED3MM  LED red
LED2             LED3MM-GRN   LED3MM  LED green
R1       1k      R-EU_0207/2V 0207/2V RESISTOR 1k
R2       1k      R-EU_0207/2V 0207/2V RESISTOR 1k
R3       10k     R-EU_0207/2V 0207/2V RESISTOR 10k
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
