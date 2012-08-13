all: pngs pnms

usage:
	@echo "usage:\n"
	@echo " make svgs  - generate pinout svg files"
	@echo " make pngs  - generate pinout png files"
	@echo " make pnms  - generate pinout pnm files"
	@echo ""

pngs: svgs
	# requires the archlinux package librsvg
	rsvg-convert -f png -z 1.0 -o ./png/t45.png   ./svg/t45.svg
	rsvg-convert -f png -z 1.0 -o ./png/t2313.png ./svg/t2313.svg
	rsvg-convert -f png -z 1.0 -o ./png/m8.png    ./svg/m8.svg
	rsvg-convert -f png -z 1.0 -o ./png/m32.png   ./svg/m32.svg

pnms: svgs
	# requires image magick
	convert png/t45.png pnm/t45.pnm
	convert png/t2313.png pnm/t2313.pnm
	convert png/m8.png pnm/m8.pnm
	convert png/m32.png pnm/m32.pnm

svgs:
	./pinout.pl --out svg --cmd pinout t45
	./pinout.pl --out svg --cmd pinout t2313
	./pinout.pl --out svg --cmd pinout m8
	./pinout.pl --out svg --cmd pinout m32

clean:
	rm svg/* png/* pnm/*
