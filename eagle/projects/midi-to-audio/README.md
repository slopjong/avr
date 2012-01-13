# Midi to Audio latency measurement adapter board

This board is very useful if you want to measure the latency of your midi controlled synth.

Simply connect the board's Midi In to your Keyboard, the board's Midi Out to your synth. And the board's Audio to your soundcard's microphone or line-in jack.

Next, start your favourite audio recording program, like Audacity or Ardour.

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

### Copyright / Contact

Copyright GPL 2005-2012 by [Jakob Flierl](https://github.com/koppi)
