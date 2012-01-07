# AVR ISP to PIN6 2.54mm and 1.27mm adapter board

This adapter board is very useful if you use AVR’s with breadboards or you want to program AVRs on smaller SMD boards.

The common 10-pin ISP jack is connected to the smaller 6-pin array - a standard 2.54mm pin array and to a 1.27mm pin array for SMD boards. You can insert the 2.54mm 6-pin inline connector directly into a breadboard.

### Circuit schematics

The adapter is compatible with the [SparkFun AVR Programming Adapter](http://www.sparkfun.com/products/8508) (sku BOB-08508). The SMD connector differs to the pinout from the 2.54mm 6-pin array, to be compatible with the SparkFun AVR SMD programming adapter.

![con-isp-pin6-sch.png](../../../../raw/master/eagle/projects/con-isp-pin6/con-isp-pin6-sch.png)

### Board layout top

![con-isp-pin6-brd-top.png](../../../../raw/master/eagle/projects/con-isp-pin6/con-isp-pin6-brd-top.png)

For the 2.54mm 6-pin array, the pin names are on the top of the PCB.

### Board layout bottom

![con-isp-pin6-brd-bot.png](../../../../raw/master/eagle/projects/con-isp-pin6/con-isp-pin6-brd-bot.png)

For the 1.27mm 6-pin array, the pin names are on the bottom of the PCB.

### Bill of Material

```
Part    Device            Package           Description
AVRISP  PINHD-1X6/90      1X06/90           PIN HEADER
AVR_ISP AVR_SPI_PROG2LOCK 2X5-SHROUDED_LOCK AVR ICSP Header
```

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
