C=convert -density 1200 -scale 848
B=m8-led-blink-smd

all:
	$(C) $(B)-sch.pdf $(B)-sch.png
	$(C) $(B)-brd-top.pdf $(B)-brd-top.png
	$(C) $(B)-brd-bot.pdf $(B)-brd-bot.png

clean:
	/bin/rm -f *.b\#? *.s\#? eagle.epf *.scr *.dru *.dsn *.pdf
