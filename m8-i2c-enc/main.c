#include <inttypes.h>

#include <avr/interrupt.h>
#include <avr/eeprom.h>

#include <util/atomic.h>
#include <util/delay.h>

#include <string.h> // for strcmp
#include <stdlib.h> // for atoi

volatile uint8_t reg[4];      // four registers
volatile int8_t reg_cur = 0;  // unsigned for wrap around
volatile int8_t val = 0, val_old = 0;

// LEDs
#define LED_DDR  DDRC
#define LED_PORT PORTC
#define LED0 0
#define LED1 1
#define LED2 2
#define LED3 3
#define LED_ALL (1<<LED0 | 1<<LED1 | 1<<LED2 | 1<<LED2)

// push buttons
#define KEY_DDR          DDRB
#define KEY_PORT         PORTB
#define KEY_PIN          PINB
#define KEY0               2
#define KEY1               3
#define KEY_ALL          (1<<KEY0 | 1<<KEY1)
#define KEY_REP_MASK     (1<<KEY0 | 1<<KEY1) // repeat: key0, key1
#define KEY_REP_START    200                  // after 500ms
#define KEY_REP_NEXT      40                  // every 200ms

volatile uint8_t key_state;
volatile uint8_t key_press;
volatile uint8_t key_rpt;

// rotary encoder
#define ENC_DDR DDRB
#define ENC_PORT PORTB
#define ENC_A (PINB & 1<<PB1)
#define ENC_B (PINB & 1<<PB0)

#define ENC_ACC_SLOW       1
#define ENC_ACC_FAST       4
#define ENC_ACC_BIG       16
#define ENC_ACC_HUGE      64

volatile uint8_t enc_acc_t10ms = 0; // count down per timer interrupt 10ms
volatile uint8_t enc_delta;         // -128 ... 127
volatile uint8_t enc_last;

// 7-segment display
#define SEG_DDR  DDRD
#define SEG_PORT PORTD

uint8_t SEG_PI[][8] = { // pins grouped by digits, last pin == cathode
  { PD5,  PD7,  PD0,  PD1,  PD2,  PD3,  PD4, PD6},
  { PD6,  PD5,  PD0,  PD1,  PD2,  PD3,  PD4, PD7}};

uint8_t SEG_PD[][8] = { // pin directions
  {DDD5, DDD7, DDD0, DDD1, DDD2, DDD3, DDD4, DDD6},
  {DDD6, DDD5, DDD0, DDD1, DDD2, DDD3, DDD4, DDD7}};

uint8_t d[] = // maps [0..9, A..F] to seven segment pins [a..g]
  { 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101,
    0b01111101, 0b00000111, 0b01111111, 0b01101111, 0b01110111, 0b01111100,
    0b00111001, 0b01011110, 0b01111001, 0b01110001 };

volatile uint8_t seg_fade_time; // fade down time

volatile uint8_t seg_fade_timer = 1;  // fade timer
volatile uint8_t seg_fade_low;        // lowest  led density
volatile uint8_t seg_fade_high;       // highest led density
volatile uint8_t seg_fade;            // highest led density
volatile uint8_t seg_dig[2];

// twi
#define TWI_BITRATE               400000

#define twi_slave_ReadBytes         0x60
#define twi_slave_WriteBytes        0xA8

#define TRUE                           1
#define FALSE                          0

#define TWI_START                   0x08
#define TWI_REP_START               0x10
#define TWI_ARB_LOST                0x38

// TWI Master Transmitter staus codes                      
#define TWI_MTX_ADR_ACK             0x18
#define TWI_MTX_ADR_NACK            0x20 
#define TWI_MTX_DATA_ACK            0x28
#define TWI_MTX_DATA_NACK           0x30

// TWI Master Receiver staus codes  
#define TWI_MRX_ADR_ACK             0x40
#define TWI_MRX_ADR_NACK            0x48
#define TWI_MRX_DATA_ACK            0x50
#define TWI_MRX_DATA_NACK           0x58

// TWI Slave Transmitter staus codes
#define TWI_STX_ADR_ACK             0xA8
#define TWI_STX_ADR_ACK_M_ARB_LOST  0xB0 
#define TWI_STX_DATA_ACK            0xB8
#define TWI_STX_DATA_NACK           0xC0
#define TWI_STX_DATA_ACK_LAST_BYTE  0xC8 

// TWI Slave Receiver staus codes
#define TWI_SRX_ADR_ACK             0x60
#define TWI_SRX_ADR_ACK_M_ARB_LOST  0x68
#define TWI_SRX_GEN_ACK             0x70
#define TWI_SRX_GEN_ACK_M_ARB_LOST  0x78
#define TWI_SRX_ADR_DATA_ACK        0x80
#define TWI_SRX_ADR_DATA_NACK       0x88
#define TWI_SRX_GEN_DATA_ACK        0x90
#define TWI_SRX_GEN_DATA_NACK       0x98
#define TWI_SRX_STOP_RESTART        0xA0

// TWI Miscellaneous status codes
#define TWI_NO_STATE                0xF8
#define TWI_BUS_ERROR               0x00

uint8_t twi_slave_addr; // slave addr

// preferences
#define EE_TWI_SLAVE  0x100 // where the twi slave address is saved
#define EE_SEG_HIGH   0x101 // where the twi slave address is saved
#define EE_SEG_LOW    0x102 // where the twi slave address is saved
#define EE_SEG_TIME   0x103 // where the twi slave address is saved

// ------------------------------ functions ---------------------------------

// eeprom
uint8_t ee_read_byte(uint16_t addr) {
  eeprom_busy_wait();
  return eeprom_read_byte((unsigned char *)addr);
}

void ee_write_byte(uint16_t addr, uint8_t value) {
  eeprom_busy_wait();
  eeprom_write_byte((unsigned char *)addr, value);
}

// twi
uint8_t twi_slave_Init (uint8_t address, uint32_t bitrate) {
  TWBR = ((F_CPU/bitrate)-16)/2;
  TWAR = (address << 1);
  TWCR = (1<<TWEN)|(1<<TWEA);
  return TRUE;
}

void twi_slave_Stop (void) {
  TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWSTO)|(1<<TWEA);
}

void twi_slave_Write (uint8_t byte) {
  TWDR = byte;
  TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWEA);
  while (!(TWCR & (1<<TWINT)));
}

uint8_t twi_slave_ReadAck (void) {
  TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWEA);
  while (!(TWCR & (1<<TWINT)));
  return TWDR;
}

uint8_t twi_slave_ReadNack (void) {
  TWCR = (1<<TWINT)|(1<<TWEN);
  while (!(TWCR & (1<<TWINT)));
  return TWDR;
}

uint8_t twi_slave_ResonseRequired (uint8_t *TWI_ResonseType) {
  *TWI_ResonseType = TWSR;
  return TWCR & (1<<TWINT);
}

void twi_init(void) {
  twi_slave_addr = ee_read_byte(EE_TWI_SLAVE);

  if (twi_slave_addr == 255) { // factory settings is i2c slave address 3
    twi_slave_addr = 3;
    ee_write_byte(EE_TWI_SLAVE, twi_slave_addr);
  }

  twi_slave_Init(twi_slave_addr, TWI_BITRATE);
}

// command line
#define NELEMS(x) sizeof(x)/sizeof(x[0])

#define INPBUFSIZ 21
#define ARGVSIZ   10

void cmd_addr(unsigned char sargc, char *sargv[]) {
  if (sargc == 2) {
    uint8_t tmp = atoi(sargv[1]);

    if (tmp > 0 && tmp < 255) {
      twi_slave_addr = tmp;
      ee_write_byte(EE_TWI_SLAVE, twi_slave_addr);
      twi_slave_Init(twi_slave_addr, TWI_BITRATE);
    }
  }
}

void cmd_seg_low(unsigned char sargc, char *sargv[]) {
  seg_fade_low = atoi(sargv[1]);
  ee_write_byte(EE_SEG_LOW, seg_fade_low);
}

void cmd_seg_high(unsigned char sargc, char *sargv[]) {
  seg_fade_high = atoi(sargv[1]);
  ee_write_byte(EE_SEG_HIGH, seg_fade_high);
}

void cmd_seg_time(unsigned char sargc, char *sargv[]) {
  seg_fade_time = atoi(sargv[1]);
  ee_write_byte(EE_SEG_TIME, seg_fade_time);
}

void cmd_reg(unsigned char sargc, char *sargv[]) {
  uint8_t reg;

  if (sargc == 2) {
    reg = atoi(sargv[1]);
    if (reg >= 0 && reg <= 3) {
      reg_cur = reg;
    }
  }
}

typedef void(*fptr)(unsigned char, char **);
typedef struct { fptr function; char *name; } command_t;

const command_t cmd[] = {
  { cmd_addr,     "addr" },
  { cmd_reg,      "reg"  },
  { cmd_seg_low,  "seg_low" },
  { cmd_seg_high, "seg_high" },
  { cmd_seg_time, "seg_time" }
};

void cmd_exec(char *buf) {
  uint8_t j, sargc;
  char *sargv[ARGVSIZ];

  j = 0; sargc = 0;
  for (uint8_t i = 0; i < ARGVSIZ; i++) {
    while (buf[j] == ' ' && buf[j] != '\0' ) j++;
    sargv[i] = &buf[j];
    if (buf[j] == '\0') break;
    sargc++;
    while(buf[j] != ' ' && buf[j] != '\0') j++;  
    if(buf[j] == '\0') break; else buf[j++] = '\0';
  }
  for (uint8_t i = 0;i < NELEMS(cmd); i++) {
    if (strcmp(sargv[0],cmd[i].name) == 0) {
      cmd[i].function(sargc, sargv); break;
    }
  }
}

// 7-segment

void seg_init(void) {
  seg_fade_low  = ee_read_byte(EE_SEG_LOW);
  if (seg_fade_low == 255) seg_fade_low = 20;

  seg_fade_high = ee_read_byte(EE_SEG_HIGH);
  if (seg_fade_high == 255) seg_fade_high = 1;

  seg_fade_time = ee_read_byte(EE_SEG_TIME);
  if (seg_fade_time == 255) seg_fade_time = 200;
}

void seg_d(uint16_t v) { // decimal output
  uint8_t *p = d;
  while (v >= 10) { v -= 10; p++; }
  seg_dig[0] = d[v]; seg_dig[1] = *p;
}

void seg_x(uint16_t v) { // hexadecimal output
  uint8_t *p = d;
  while (v >= 16) { v -= 16; p++; }
  seg_dig[0] = d[v]; seg_dig[1] = *p;
}

// leds
void led_init(void) {
  LED_DDR  |= LED_ALL;
}

// push buttons
uint8_t key_get_press(uint8_t key_mask) {
  ATOMIC_BLOCK (ATOMIC_FORCEON) {
    key_mask &= key_press;
    key_press ^= key_mask;
  }
  return key_mask;
}

uint8_t key_get_rpt(uint8_t key_mask) {
  ATOMIC_BLOCK (ATOMIC_FORCEON) {
    key_mask &= key_rpt;
    key_rpt ^= key_mask;
  }
  return key_mask;
}

uint8_t key_get_short( uint8_t key_mask ) {
  uint8_t kval;
  ATOMIC_BLOCK (ATOMIC_FORCEON) {
    kval = key_get_press( ~key_state & key_mask );
  }
  return kval;
}

uint8_t key_get_long(uint8_t key_mask) {
  return key_get_press(key_get_rpt(key_mask));
}

void key_init(void) {
  KEY_DDR &= ~KEY_ALL; // key port dir is in
  KEY_PORT |= KEY_ALL; // and turn on pull up Rs
}

void enc_init(void) {
  int8_t new = 0;

  ENC_DDR  &= ~(1<<DDB1); // enc  A
  ENC_PORT |=  (1<<PB1);  // pullup

  ENC_DDR  &= ~(1<<DDB0); // enc  B
  ENC_PORT |=  (1<<PB0);  // pullup

  if (ENC_A) { new = 3; } if (ENC_B) { new ^= 1; }
  enc_last = new; enc_delta = 0;
}

int8_t enc_read4(void) {
  int8_t eval;
  ATOMIC_BLOCK (ATOMIC_FORCEON) {
    eval = enc_delta;
    enc_delta = eval & 3;
  }
  return eval >> 2;
}

int16_t enc_acc(void) {
  if (enc_acc_t10ms > 0) return 0;

  enc_acc_t10ms = 200;
  int8_t eval = enc_read4();

  switch (eval) {
  case -ENC_ACC_SLOW   ...  ENC_ACC_SLOW:   return  eval;
  case  ENC_ACC_SLOW+1 ...  ENC_ACC_FAST:   return  ENC_ACC_BIG;
  case -ENC_ACC_FAST   ... -ENC_ACC_SLOW-1: return -ENC_ACC_BIG;
  case  ENC_ACC_FAST+1 ...  127:            return  ENC_ACC_HUGE;
  default:                                  return -ENC_ACC_HUGE;
  }
}

// -------------------------- timer 0 interrupt -----------------------------
ISR(TIMER0_OVF_vect) {

  // keys
  static uint8_t ct0, ct1, rpt;
  uint8_t i;
  
  i = key_state ^ ~KEY_PIN;               // key changed ?
  ct0 = ~( ct0 & i );                     // reset or count ct0
  ct1 = ct0 ^ (ct1 & i);                  // reset or count ct1
  i &= ct0 & ct1;                         // count until roll over ?
  key_state ^= i;                         // then toggle debounced state
  key_press |= key_state & i;             // 0->1: key press detect
  
  if ((key_state & KEY_REP_MASK) == 0)    // check repeat function
    rpt = KEY_REP_START;                  // start delay
  if (--rpt == 0) {
    rpt = KEY_REP_NEXT;                   // repeat delay
    key_rpt |= key_state & KEY_REP_MASK;
  }

  static uint8_t cd = 0; // current 7-segment display
  if (cd > 1) { SEG_DDR = 0; SEG_PORT = 0; } else {
    for (i = 0; i < 7; i++) {
      if (seg_dig[cd] & (1 << i)) {
		SEG_DDR  |=  (1 << SEG_PD[cd][i]); SEG_PORT &= ~(1 << SEG_PI[cd][i]);
      } else {
		SEG_DDR  &= ~(1 << SEG_PD[cd][i]); SEG_PORT |=  (1 << SEG_PI[cd][i]);
      }
    }
    
    SEG_DDR  |= (1 << SEG_PD[cd][7]);
    SEG_PORT |= (1 << SEG_PI[cd][7]);
  }
  
  if (++cd > 1 + seg_fade) cd = 0;

  if (--seg_fade_timer == 0) {
    seg_fade_timer = seg_fade_time;
    if (seg_fade < seg_fade_low) seg_fade++;
  }

  // encoder
  int8_t new = 0, diff;
 
  if (ENC_A) { new = 3; } if (ENC_B) { new ^= 1; } diff = enc_last - new;
  if (diff & 1) { enc_last = new; enc_delta += (diff & 2) - 1; }

  enc_acc_t10ms--;
}

// -------------------------- timer 1 interrupt -----------------------------
ISR(TIMER1_OVF_vect) {
  uint8_t byte; // twi

#define MAX_BUF_LEN 20

  static uint8_t twi_buf_pos = 0;
  static char twi_buf[MAX_BUF_LEN+1];

  uint8_t twi_slave_ResonseType;

  if (twi_slave_ResonseRequired (&twi_slave_ResonseType)) {
    switch (twi_slave_ResonseType) {
  
    case twi_slave_ReadBytes:
      byte = twi_slave_ReadNack();
      twi_slave_Stop();
      val = byte;
      
      if (twi_buf_pos >= MAX_BUF_LEN) {
		twi_buf[MAX_BUF_LEN] = '\0';
		twi_buf_pos = MAX_BUF_LEN + 1;
      } else {
		twi_buf[twi_buf_pos] = byte;
		twi_buf_pos++;
      }
      
      if (twi_buf_pos > 0 && twi_buf[twi_buf_pos-1] == '\0') {
		twi_buf_pos = 0; cmd_exec(twi_buf);
      }
      break;
        
    case twi_slave_WriteBytes:
      twi_slave_Write(val);
      twi_slave_Stop();
      break;
    }
  }
}

int main(void) {

  // timer
  TCCR0 = (1<<CS01); TIMSK |= (1<<TOIE0); TCNT0 = 0xff;
  TCCR1B = 1<<CS10;  TIMSK |= (1<<TOIE1);

  // init all subsystems
  led_init(); seg_init(); enc_init(); key_init(); twi_init(); sei();

  while (1) {

    if (key_get_short(1<<KEY0)) { reg_cur++; }
    if (key_get_short(1<<KEY1)) { reg_cur--; }

    if (reg_cur < 0) { reg_cur = 3; }
    if (reg_cur > 3) { reg_cur = 0; }

    for (uint8_t i = 0; i < 4; i++) {
      if (reg_cur == i) {
		LED_PORT |= (1<<(LED0+i));
      } else {
		LED_PORT &= ~(1<<(LED0+i));
      }
    }

    val_old = val = reg[reg_cur];
    val += enc_acc();

    if (val < 0) val = 0;
    if (val > 0xff) val = 0xff;

    reg[reg_cur] = val;

    // brighten display iff value changes
    if (val != val_old) {
      seg_fade = seg_fade_high;
      seg_fade_timer = seg_fade_time;
    }

    seg_x(val);    // hex
    // seg_d(val); // decimal
  }
}
