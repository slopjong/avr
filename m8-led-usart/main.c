#include <avr/io.h>
#include <inttypes.h>
#include <util/delay.h>

#include "usart.h"

FILE uart_str = FDEV_SETUP_STREAM(uart_putchar, uart_getchar, _FDEV_SETUP_RW);

int main(void) {
  char buf[RX_BUFSIZE]; // rtx buffer

  DDRD|= (1<<DDD5); DDRD|= (1<<DDD6); // dir PD5/PD6 out

  uart_init(); stdout = stdin = &uart_str;

  for (;;) {
    fprintf(stdout, "Enter command ('a' or 'b'): ");

    if (fgets(buf, sizeof buf - 1, stdin) != NULL) {
      switch (buf[0]) {
	  case 'a':
		// pin PD5 = 0V, LED1 on
		PORTD &= ~(1<<PD5);  // LED1 off
		fprintf(stdout, "LED1 off\n");
		break;
	  case 'b':
		PORTD |= (1<<PD5);   // LED1 on
		fprintf(stdout, "LED1 on\n");
		break;
	  }
    }

    PORTD|= (1<<PD6); // LED2 on
    _delay_ms(50);

    PORTD &= ~(1<<PD6);
    _delay_ms(50);    // LED2 off
  }

  return 0;
}
