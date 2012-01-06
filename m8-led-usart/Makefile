MCU=atmega8

CFLAGS=-DUART_BAUD=9600 -DF_CPU=1000000UL -Os -mmcu=$(MCU) -Wall -Wstrict-prototypes -mcall-prologues

CC=avr-gcc
OBJCOPY=avr-objcopy

all: main.hex

main.hex : main.out 
	$(OBJCOPY) -R .eeprom -O ihex main.out main.hex 

main.out : main.o usart.o
	$(CC) $(CFLAGS) -o main.out -Wl,-Map,main.map main.o usart.o

main.o : main.c 
	$(CC) $(CFLAGS) -c main.c

usart.o : usart.c 
	$(CC) $(CFLAGS) -c usart.c

clean:
	make -C cmd clean
	/bin/rm -f *.o *.map *.out *.hex
