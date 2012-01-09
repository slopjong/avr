C=convert -density 1200 -scale 848
B=m8-usb-i2c-smd

all:
	$(C) $(B)-sch.pdf $(B)-sch.png
	$(C) $(B)-brd.pdf $(B)-brd.png

clean:
	/bin/rm -f *.b\#? *.s\#? eagle.epf *.scr *.dru *.dsn *.pdf
