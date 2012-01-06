all:
	@echo "usage:\n"
	@echo " make svgs  - generate pinout svg files"
	@echo " make pngs  - generate pinout png files"
	@echo ""

pngs: svgs
	rsvg-convert -f png -z 1.0 -o t45.png   t45.svg
	rsvg-convert -f png -z 1.0 -o t2313.png t2313.svg
	rsvg-convert -f png -z 1.0 -o m8.png    m8.svg
	rsvg-convert -f png -z 1.0 -o m32.png   m32.svg

svgs:
	./pinout.pl --out . --cmd pinout t45
	./pinout.pl --out . --cmd pinout t2313
	./pinout.pl --out . --cmd pinout m8
	./pinout.pl --out . --cmd pinout m32

clean:
	make -C m8-led-blink clean
	/bin/rm -f t45.svg t2313.svg m8.svg m32.svg
