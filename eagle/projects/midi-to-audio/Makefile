C=convert -density 1200 -scale 848
B=midi-to-audio

all: gerber

gerber:
	gbtiler --argfile gbtiler.cfg

png:
	$(C) $(B)-sch.pdf $(B)-sch.png
	$(C) $(B)-brd.pdf $(B)-brd.png

clean:
	/bin/rm -f *.b\#? *.s\#? eagle.epf *.scr *.dru *.dsn *.pdf *.bor *.cmp *.drd *.dri *.gpi *.plc *.pls *.sol *.stc *.sts
