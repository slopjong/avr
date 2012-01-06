#include <avr/io.h>
#include <inttypes.h>

#define F_CPU 1000000UL  // 1 MHz
// #define F_CPU 16000000UL  // 16 MHz
#include <util/delay.h>

int main(void) {
  DDRD|= (1<<DDD5); // dir PD5 out
  DDRD|= (1<<DDD6); // dir PD6 out
  
  while (1) {
	// pin PD5 = 0V, LED1 on
	PORTD &= ~(1<<PD5);
	// pin PD6 = 5V, LED2 off
	PORTD|= (1<<PD6);

	_delay_ms(250);

	// pin PD5 = 5V, LED1 off
	PORTD|= (1<<PD5);
	// pin PD5 = 0V, LED2 on
	PORTD &= ~(1<<PD6);

	_delay_ms(250);
  }

  return 0;
}
