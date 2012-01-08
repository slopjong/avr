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

* Reichelt order list - [con-isp-pin6](https://secure.reichelt.de/index.html?;ACTION=20;AWKID=524822;PROVID=2084). Sum 0.67 EUR.

### Eagle library parts

When designing your AVR board, you can take the 1.27mm ISP adapter definition from the SparkFun Eagle Library [SparkFun.lbr](https://github.com/sparkfun/SparkFun-Eagle-Library) available at GitHub.

The 1.27mm 6-pin SMD ISP connector is called "AVR_PROGMINISMD" in SparkFun.lbr. You can add the part to your Eagle schematics with the following command:

```
add AVR_PROGMINISMD
```

![con-isp-pin6-smd.png](../../../../raw/master/eagle/projects/con-isp-pin6/con-isp-pin6-smd.png)

The 2.54mm 6-pin ISP connector part is called "PINHD-1X6" (or "PINHD-1X6/90" for the rotated version) in the Eagle pinhead.lbr. You can add the part to your Eagle schematics with the following command:

```
add PINHD-1X6
```

![con-isp-pin6-dil.png](../../../../raw/master/eagle/projects/con-isp-pin6/con-isp-pin6-dil.png)

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
