all:
	make -C m8-*
	make -C pinouts svgs
	make -C pinouts pngs

pinouts:
	make -f pinouts/Makefile svgs
	make -f pinouts/Makefile pngs

m8:
	make -C m8-*

clean:
	make -C m8-led-blink clean
	make -C m8-led-usart clean
	make -C m8-i2c-enc   clean
	rm pinouts/svg/* pinouts/png/*
