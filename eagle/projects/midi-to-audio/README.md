# Midi to Audio latency measurement adapter board

There was an interesting article called [THE TRUTH ABOUT LATENCY - Soft Synth Latency And Latency Jitter: Real-world Tests](http://www.soundonsound.com/sos/Sep02/articles/pcmusician0902.asp) in the Sound On Sound magazine, September 2002.

The adapter board below is very useful if you want to measure the latency of your midi controlled synth. Simply connect the board's Midi In to your Keyboard, the board's Midi Out to your synth. And the board's audio connector to your soundcard's right microphone or line-in channel as shown in the following figure:

![2000-09-sos-con.png](../../../../raw/master/eagle/projects/midi-to-audio/2000-09-sos-con.png)

Next, start your favourite audio recording program, like Wavelab, Audacity or Ardour and play a note on your keyboard. Watch the Midi signals and the synth's audio signals and their relative offsets:

![2000-09-sos-lat.png](../../../../raw/master/eagle/projects/midi-to-audio/2000-09-sos-lat.png)

This works with hardware and software synths.

### Order your midi-to-audio adapter

The first batch of 56 adapters is in production. Go to the [order form](https://docs.google.com/spreadsheet/viewform?hl=en_US&formkey=dGhXZGtpOGRWU2lNNGhZal93R1BjQVE6MQ) to register for the next batch. We will contact you back when we're ready for the next batch run in 02/2012.

### Circuit schematics

![midi-to-audio-sch.png](../../../../raw/master/eagle/projects/midi-to-audio/midi-to-audio-sch.png)

### Board layout

![midi-to-audio-brd.png](../../../../raw/master/eagle/projects/midi-to-audio/midi-to-audio-brd.png)

### Bill of Materials

```
Part    Value  Device       Package Description
AUDIO   TOBU3  TOBU3        TOBU3   Female Cinch CONNECTOR ( RCA Jack )
MIDIIN  MAB5SH MAB5SH       MAB5SH  Female CONNECTOR
MIDIOUT MAB5SH MAB5SH       MAB5SH  Female CONNECTOR
R1      5.1k   R-EU_0207/10 0207/10 RESISTOR
```

*   Reichelt order list: [midi-to-audio](http://www.reichelt.de/?ACTION=20;AWKID=527545;PROVID=2084) price: 1.52 EUR.

### Gerber files (7x2)

The directory workspace/ (linked above) contains the gerber files for the tiled version (7x2 boards) for the 100x160mm euro format:

![midi-to-audio-ger.png](../../../../raw/master/eagle/projects/midi-to-audio/midi-to-audio-ger.png)

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
