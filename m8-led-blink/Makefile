MCU=atmega8

CFLAGS=-g -mmcu=$(MCU) -Wall -Wstrict-prototypes -Os -mcall-prologues

CC=avr-gcc
OBJCOPY=avr-objcopy

all: main.hex

main.hex : main.out 
	$(OBJCOPY) -R .eeprom -O ihex main.out main.hex 

main.out : main.o 
	$(CC) $(CFLAGS) -o main.out -Wl,-Map,main.map main.o

main.o : main.c 
	$(CC) $(CFLAGS) -c main.c

clean:
	/bin/rm -f *.o *.map *.out *.hex
