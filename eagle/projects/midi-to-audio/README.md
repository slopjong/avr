# Midi to Audio latency measurement adapter board

There was an interesting article called [THE TRUTH ABOUT LATENCY - Soft Synth Latency And Latency Jitter: Real-world Tests](http://www.soundonsound.com/sos/Sep02/articles/pcmusician0902.asp) in the Sound On Sound, September 2002.

This board is very useful if you want to measure the latency of your midi controlled synth. Simply connect the board's Midi In to your Keyboard, the board's Midi Out to your synth. And the board's Audio to your soundcard's microphone or line-in jack.

![2000-09-sos-con.png](../../../../raw/master/eagle/projects/midi-to-audio/2000-09-sos-con.png)

Next, start your favourite audio recording program, like Audacity or Ardour:

![2000-09-sos-lat.png](../../../../raw/master/eagle/projects/midi-to-audio/2000-09-sos-lat.png)

Play a note on your keyboard and watch the relative latency offsets between the Midi signal and the synth's audio signal.

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
