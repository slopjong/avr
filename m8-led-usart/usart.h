#include <stdint.h>
#include <stdio.h>

#include <avr/io.h>

#define RX_BUFSIZE 10

void uart_init(void);
int	uart_putchar(char c, FILE *stream);
int	uart_getchar(FILE *stream);
