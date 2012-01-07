C=convert -density 1200 -scale 848

all:
	$(C) con-isp-pin6-sch.pdf con-isp-pin6-sch.png
	$(C) con-isp-pin6-brd-top.pdf con-isp-pin6-brd-top.png
	$(C) con-isp-pin6-brd-bot.pdf con-isp-pin6-brd-bot.png

clean:
	/bin/rm -f *.b\#? *.s\#? eagle.epf *.scr *.dru *.dsn
