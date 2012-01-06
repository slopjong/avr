MCU := atmega8

CFLAGS := -DF_CPU=1000000UL -mmcu=$(MCU) \
          -Wall --std=gnu99 -Wstrict-prototypes \
		  -Os -mcall-prologues

all: main.hex

main.hex : main.out 
	avr-objcopy -R .eeprom -O ihex main.out main.hex 

main.out : main.o
	avr-gcc $(CFLAGS) -o main.out -Wl,-Map,main.map main.o

main.o : main.c 
	avr-gcc $(CFLAGS) -c main.c

program: main.hex
	avrdude -p $(MCU) -P usb -c avrispmkII -U flash:w:main.hex

clean:
	rm -f *.o *.map *.out *.hex *~
