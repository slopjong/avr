# ATmega8 LED blink DIL test board

This board is very useful if you want to get started with programming AVR’s.

The board contains two LEDs, which can then be controlled in your C program. See [avr/m8-led-blink](../../../../tree/master/m8-led-blink) for the C source code "main.c".

### Circuit schematics

The board's ATmega8 is connected to the board components as follows:

* LED1 - ATmega8 PD5
* LED2 - ATmega8 PD6

![m8-led-blink-dil-sch.png](../../../../raw/master/eagle/projects/m8-led-blink-dil/m8-led-blink-dil-sch.png)

### Board layout

![m8-led-blink-dil-brd.png](../../../../raw/master/eagle/projects/m8-led-blink-dil/m8-led-blink-dil-brd.png)

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

*   Reichelt order list: [m8-led-blink-dil](http://www.reichelt.de/?ACTION=20;AWKID=524851;PROVID=2084) price: 12.62 EUR.

    Notice, the above order list also contains two IC test sockets, which might get useful for breadboard based test circuit experiments and general AVR programming: [DIL 28 NG](http://www.reichelt.de/index.html?ACTION=3;ARTICLE=113267) price: 5.30 EUR and [NIF 28](http://www.reichelt.de/index.html?;ACTION=3;LA=5010;ARTICLE=13450) price: 3.70 EUR:
	
![reichelt-sockel.png](../../../../raw/master/eagle/projects/m8-led-blink-dil/reichelt-sockel.png)

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
